import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart' as enc;
import 'package:archive/archive_io.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

import 'package:miros_share_and_web_dock/features/send/core/config/app_config.dart';
import 'package:miros_share_and_web_dock/features/send/core/utils/logger.dart';
import '../../domain/entities/protocol_packet.dart';
import '../../domain/entities/transfer_session.dart';
import '../../domain/repositories/transfer_repository.dart';
import '../datasources/tcp_client_datasource.dart';
import '../datasources/tcp_server_datasource.dart';
import '../datasources/protocol_codec.dart';

class TransferRepositoryImpl implements TransferRepository {
  final TcpClientDataSource _client;
  final TcpServerDataSource _server;
  
  // Sending state
  final _sendProgressController = StreamController<double>.broadcast();
  final _senderStepController = StreamController<SenderStep>.broadcast();
  bool _isSendCancelled = false;

  // Receiving state
  final _incomingTransferController = StreamController<IncomingTransfer?>.broadcast();
  IncomingTransfer? _currentIncomingTransfer;
  IOSink? _currentReceiveSink;
  Socket? _currentReceiveSocket;
  int _totalBytesReceived = 0;
  String? _tempFilePath;
  String? _finalFilePath;
  enc.Encrypter? _receiveFernet;
  enc.IV? _receiveIv;
  Completer<void>? _receiveProcessingLock;

  TransferRepositoryImpl({
    required TcpClientDataSource client,
    required TcpServerDataSource server,
  }) : _client = client, _server = server {
    _server.packetStream.listen(_onIncomingPacketWrapper);
  }

  // --- SENDING ---

  @override
  Stream<double> get sendProgressStream => _sendProgressController.stream;

  @override
  Stream<SenderStep> get senderStepStream => _senderStepController.stream;

  @override
  void cancelSend() {
    logger.i('[Sender] Cancel requested');
    _isSendCancelled = true;
    _client.sendPacket(const ProtocolPacket(type: PacketType.cancel, data: {}));
    _client.disconnect();
    _senderStepController.add(SenderStep.cancelled);
  }

  @override
  Future<void> sendFiles(List<File> files, String targetIp, int targetPort, {List<String>? alternativeIps}) async {
    final sessionId = const Uuid().v4();
    _isSendCancelled = false;
    
    final sessionKey = enc.Key.fromSecureRandom(32);
    final iv = enc.IV.fromSecureRandom(16);
    final fernet = enc.Encrypter(enc.AES(sessionKey, mode: enc.AESMode.cbc));

    final tempFilesToCleanup = <File>[];

    try {
      _senderStepController.add(SenderStep.connecting);
      
      bool connected = await _client.connect(targetIp, targetPort, alternativeIps: alternativeIps);

      if (!connected) {
        logger.e('[Sender] Connection failed to all targets');
        _senderStepController.add(SenderStep.error);
        return;
      }

      // Handshake: START LISTENING FIRST to avoid race condition
      logger.i('[Sender] Connection established. Waiting for Hello reply...');
      final helloCompleter = Completer<void>();
      final helloSub = _client.packetStream.listen((p) {
        logger.i('[Sender] Received packet during handshake: ${p.type}');
        if (p.type == PacketType.hello) {
          if (!helloCompleter.isCompleted) helloCompleter.complete();
        }
      });

      try {
        // Now send the handshake trigger AFTER the listener is attached
        logger.i('[Sender] Initiating Handshake trigger...');
        await _client.sendPacket(const ProtocolPacket(type: PacketType.hello, data: {}));

        await helloCompleter.future.timeout(const Duration(seconds: 20));
        logger.i('[Sender] Handshake successful!');
      } catch (e) {
        logger.e('[Sender] Handshake Timeout - Receiver did not reply with Hello');
        _senderStepController.add(SenderStep.error);
        _client.disconnect();
        return;
      } finally {
        await helloSub.cancel();
      }

      int totalTransferSize = 0;
      List<FileMetadata> metadatas = [];
      List<File> processedFiles = [];

      logger.i('[Sender] Preparing ${files.length} files...');
      for (var f in files) {
        final originalSize = await f.length();
        bool useCompression = originalSize > 20 * 1024 * 1024;

        File fileToStream = f;
        String fileName = p.basename(f.path);

        final originalBytes = await f.readAsBytes();
        final originalHash = sha256.convert(originalBytes).toString();

        if (useCompression) {
          logger.i('[Sender] Compressing $fileName...');
          final tempDir = await getTemporaryDirectory();
          final zipPath = p.join(tempDir.path, '$fileName.miros.zip');
          final encoder = ZipFileEncoder();
          encoder.create(zipPath);
          await encoder.addFile(f);
          encoder.close();
          fileToStream = File(zipPath);
          tempFilesToCleanup.add(fileToStream);
        }

        processedFiles.add(fileToStream);
        final streamSize = await fileToStream.length();
        totalTransferSize += streamSize;

        metadatas.add(FileMetadata(
          name: fileName,
          extension: p.extension(f.path),
          mimeType: 'application/octet-stream',
          size: streamSize,
          sha256: originalHash,
          lastModified: f.lastModifiedSync().millisecondsSinceEpoch,
          chunkCount: (streamSize / AppConfig.defaultChunkSize).ceil(),
          chunkSize: AppConfig.defaultChunkSize,
          encryptionEnabled: true,
          compressionEnabled: useCompression,
        ));
      }

      if (_isSendCancelled) return;

      logger.i('[Sender] Sending batch manifest...');
      await _client.sendPacket(ProtocolPacket(
        type: PacketType.batchHeader,
        data: {
          ...BatchMetadata(fileCount: files.length, totalSize: totalTransferSize, files: metadatas).toJson(),
          'e2ee_key': base64.encode(sessionKey.bytes),
          'e2ee_iv': base64.encode(iv.bytes),
        },
        sessionId: sessionId,
      ));

      _senderStepController.add(SenderStep.waitingForAccept);
      logger.i('[Sender] Waiting for receiver to accept transfer...');
      final acceptCompleter = Completer<bool>();
      final sub = _client.packetStream.listen((packet) {
        if (packet.sessionId == sessionId) {
          if (packet.type == PacketType.pairAccept) {
            logger.i('[Sender] Transfer accepted');
            acceptCompleter.complete(true);
          } else if (packet.type == PacketType.pairDeny) {
            logger.w('[Sender] Transfer denied');
            acceptCompleter.complete(false);
          } else if (packet.type == PacketType.cancel) {
            logger.w('[Sender] Transfer cancelled by receiver');
            acceptCompleter.complete(false);
          }
        }
      });

      final bool isAuthorized = await acceptCompleter.future.timeout(const Duration(minutes: 5), onTimeout: () => false);
      await sub.cancel();

      if (_isSendCancelled) return;
      if (!isAuthorized) {
        logger.e('[Sender] Transfer not authorized');
        _senderStepController.add(SenderStep.error);
        _client.disconnect();
        return;
      }

      _senderStepController.add(SenderStep.streaming);
      int totalSent = 0;
      for (int i = 0; i < processedFiles.length; i++) {
        if (_isSendCancelled) break;

        logger.i('[Sender] Sending file ${i + 1}/${processedFiles.length}: ${metadatas[i].name}');
        await _client.sendPacket(ProtocolPacket(
          type: PacketType.fileHeader,
          data: metadatas[i].toJson(),
          sessionId: sessionId,
        ));

        final fileStream = processedFiles[i].openRead();
        await for (final chunk in fileStream) {
          if (_isSendCancelled) break;
          final encrypted = fernet.encryptBytes(chunk, iv: iv);
          
          await _client.sendPacket(ProtocolPacket(
            type: PacketType.chunk,
            data: {'data': encrypted.base64},
            sessionId: sessionId,
          ));
          totalSent += chunk.length;
          _sendProgressController.add(totalSent / totalTransferSize);
        }

        if (_isSendCancelled) break;
        await _client.sendPacket(ProtocolPacket(type: PacketType.complete, data: {}, sessionId: sessionId));
      }

      if (_isSendCancelled) {
        _senderStepController.add(SenderStep.cancelled);
        _client.disconnect();
        return;
      }

      logger.i('[Sender] Batch complete. Waiting for ACK...');
      await _client.sendPacket(ProtocolPacket(type: PacketType.batchComplete, data: {}, sessionId: sessionId));
      
      final done = Completer<void>();
      final doneSub = _client.packetStream.listen((p) {
        if (p.sessionId == sessionId && p.type == PacketType.ack) {
          logger.i('[Sender] Received final ACK');
          done.complete();
        }
      });
      await done.future.timeout(const Duration(seconds: 15), onTimeout: () {
        logger.w('[Sender] Did not receive final ACK (timeout)');
      });
      await doneSub.cancel();

      _senderStepController.add(SenderStep.complete);
      logger.i('[Sender] Uplink successful');
      _client.disconnect();
    } catch (e) {
      logger.e('[Sender] Critical error: $e');
      if (!_isSendCancelled) _senderStepController.add(SenderStep.error);
      _client.disconnect();
    } finally {
      for (var f in tempFilesToCleanup) {
        if (f.existsSync()) f.deleteSync();
      }
    }
  }

  // --- RECEIVING ---

  @override
  Stream<IncomingTransfer?> get incomingTransferStream => _incomingTransferController.stream;

  @override
  Future<void> startServer() async {
    logger.i('[Receiver] Starting server...');
    await _server.start();
  }

  @override
  void stopServer() {
    logger.i('[Receiver] Stopping server');
    _server.stop();
  }

  void _onIncomingPacketWrapper(TcpPacketWrapper wrapper) async {
    // Handshake: If we receive a Hello, we MUST reply with a Hello
    if (wrapper.packet.type == PacketType.hello) {
       logger.i('[Receiver] Received Hello from peer (${wrapper.socket.remoteAddress.address}), replying...');
       wrapper.socket.add(ProtocolCodec.encode(const ProtocolPacket(type: PacketType.hello, data: {})));
       await wrapper.socket.flush();
       return;
    }

    if (wrapper.packet.type == PacketType.heartbeat) {
       return;
    }

    while (_receiveProcessingLock != null && !_receiveProcessingLock!.isCompleted) {
      await _receiveProcessingLock!.future;
    }
    _receiveProcessingLock = Completer<void>();
    try {
      await _handleIncomingPacket(wrapper);
    } finally {
      _receiveProcessingLock!.complete();
    }
  }

  Future<void> _handleIncomingPacket(TcpPacketWrapper wrapper) async {
    final packet = wrapper.packet;
    
    // Treat batchHeader as a potential session reset
    if (packet.type == PacketType.batchHeader) {
      if (_currentIncomingTransfer != null && _currentIncomingTransfer!.status == TransferStatus.transferring) {
        logger.w('[Receiver] A transfer is already in progress. Ignoring new request.');
        return;
      }
      logger.i('[Receiver] New session starting: ${packet.sessionId}');
    } else if (_currentIncomingTransfer != null && packet.sessionId != _currentIncomingTransfer!.sessionId) {
      logger.w('[Receiver] Ignoring packet from different session (Current: ${_currentIncomingTransfer!.sessionId}, Received: ${packet.sessionId})');
      return;
    }

    try {
      if (packet.type == PacketType.batchHeader) {
        logger.i('[Receiver] Incoming batch from ${wrapper.socket.remoteAddress.address}');
        final meta = BatchMetadata.fromJson(packet.data);
        _currentReceiveSocket = wrapper.socket;
        _totalBytesReceived = 0;
        
        if (packet.data['e2ee_key'] != null) {
          final keyBytes = base64.decode(packet.data['e2ee_key']);
          final ivBytes = base64.decode(packet.data['e2ee_iv']);
          _receiveIv = enc.IV(ivBytes);
          _receiveFernet = enc.Encrypter(enc.AES(enc.Key(keyBytes), mode: enc.AESMode.cbc));
        }

        _currentIncomingTransfer = IncomingTransfer(
          sessionId: packet.sessionId ?? '',
          batchMetadata: meta,
          status: TransferStatus.waiting,
          progress: 0,
          savedPaths: [],
        );
        _incomingTransferController.add(_currentIncomingTransfer);
      } else if (_currentIncomingTransfer != null && packet.sessionId == _currentIncomingTransfer!.sessionId) {
        if (packet.type == PacketType.cancel) {
          logger.w('[Receiver] Peer cancelled transfer');
          await _currentReceiveSink?.close();
          _currentReceiveSink = null;
          if (_tempFilePath != null) {
            final f = File(_tempFilePath!);
            if (f.existsSync()) f.deleteSync();
          }
          _currentIncomingTransfer = _currentIncomingTransfer?.copyWith(status: TransferStatus.cancelled);
          _incomingTransferController.add(_currentIncomingTransfer);
          return;
        }

        if (packet.type == PacketType.fileHeader) {
          final fileMeta = FileMetadata.fromJson(packet.data);
          logger.i('[Receiver] Receiving file: ${fileMeta.name}');
          final saveDir = await _getSaveDir();
          _finalFilePath = p.join(saveDir.path, fileMeta.name);
          _tempFilePath = '$_finalFilePath.tmp';
          
          final tempFile = File(_tempFilePath!);
          if (tempFile.existsSync()) await tempFile.delete();
          
          _currentReceiveSink = tempFile.openWrite();
          _currentIncomingTransfer = _currentIncomingTransfer?.copyWith(currentFileMetadata: fileMeta, status: TransferStatus.transferring);
          _incomingTransferController.add(_currentIncomingTransfer);
        } else if (packet.type == PacketType.chunk && _currentReceiveSink != null && _receiveFernet != null) {
          final base64Data = packet.data['data'] as String;
          final decryptedBytes = _receiveFernet!.decryptBytes(enc.Encrypted.fromBase64(base64Data), iv: _receiveIv!);
          _currentReceiveSink!.add(decryptedBytes);
          
          _totalBytesReceived += decryptedBytes.length;
          final progress = _totalBytesReceived / _currentIncomingTransfer!.batchMetadata.totalSize;
          _currentIncomingTransfer = _currentIncomingTransfer?.copyWith(progress: progress.clamp(0.0, 1.0));
          _incomingTransferController.add(_currentIncomingTransfer);
        } else if (packet.type == PacketType.complete) {
          if (_currentReceiveSink != null) {
            logger.i('[Receiver] File transmission complete. Verifying...');
            await _currentReceiveSink!.flush();
            await _currentReceiveSink!.close();
            _currentReceiveSink = null;
            
            final tempFile = File(_tempFilePath!);
            final streamSize = await tempFile.length();
            
            if (streamSize != _currentIncomingTransfer!.currentFileMetadata!.size) {
               logger.e('[Receiver] Size mismatch for ${_currentIncomingTransfer!.currentFileMetadata!.name}');
               throw Exception('Size Mismatch: Received $streamSize, Expected ${_currentIncomingTransfer!.currentFileMetadata!.size}');
            }

            String currentFilePath = _tempFilePath!;

            if (_currentIncomingTransfer!.currentFileMetadata!.compressionEnabled) {
              logger.i('[Receiver] Decompressing...');
              final saveDir = await _getSaveDir();
              final fileBytes = await tempFile.readAsBytes();
              final archive = ZipDecoder().decodeBytes(fileBytes);
              for (final file in archive) {
                if (file.isFile) {
                  final out = File(p.join(saveDir.path, file.name));
                  await out.writeAsBytes(file.content as List<int>);
                  currentFilePath = out.path; 
                }
              }
              await tempFile.delete();
            }

            logger.i('[Receiver] Performing Integrity Check (SHA-256)...');
            final finalFile = File(currentFilePath);
            final fileBytes = await finalFile.readAsBytes();
            final actualHash = sha256.convert(fileBytes).toString();
            
            if (_currentIncomingTransfer!.currentFileMetadata?.sha256 != '' && 
                _currentIncomingTransfer!.currentFileMetadata?.sha256 != actualHash) {
              logger.e('[Receiver] Hash mismatch! DELETING CORRUPTED DATA');
              if (finalFile.existsSync()) finalFile.deleteSync();
              throw Exception('Hash Mismatch: Data Corruption Detected');
            }

            if (currentFilePath.endsWith('.tmp')) {
              await finalFile.rename(_finalFilePath!);
              currentFilePath = _finalFilePath!;
            }

            logger.i('[Receiver] File saved successfully: $currentFilePath');
            final paths = List<String>.from(_currentIncomingTransfer!.savedPaths)..add(currentFilePath);
            _currentIncomingTransfer = _currentIncomingTransfer?.copyWith(savedPaths: paths);
            _incomingTransferController.add(_currentIncomingTransfer);
          }
        } else if (packet.type == PacketType.batchComplete) {
          logger.i('[Receiver] Batch complete. Sending ACK');
          _currentIncomingTransfer = _currentIncomingTransfer?.copyWith(status: TransferStatus.completed, progress: 1.0);
          _incomingTransferController.add(_currentIncomingTransfer);
          if (_currentReceiveSocket != null) {
            _currentReceiveSocket!.add(ProtocolCodec.encode(ProtocolPacket(
              type: PacketType.ack, data: {}, sessionId: _currentIncomingTransfer!.sessionId,
            )));
            await _currentReceiveSocket!.flush();
          }
          _currentReceiveSocket = null;
          _receiveFernet = null;
        }
      }
    } catch (e) {
      logger.e('[Receiver] Error: $e');
      _currentIncomingTransfer = _currentIncomingTransfer?.copyWith(status: TransferStatus.error, error: e.toString());
      _incomingTransferController.add(_currentIncomingTransfer);
      await _currentReceiveSink?.close();
      _currentReceiveSink = null;
      if (_tempFilePath != null) {
        final f = File(_tempFilePath!);
        if (f.existsSync()) f.deleteSync();
      }
    }
  }

  @override
  Future<void> acceptTransfer(String sessionId) async {
    if (_currentIncomingTransfer == null || _currentReceiveSocket == null) return;
    logger.i('[Receiver] Sending Accept to peer');
    _currentReceiveSocket!.add(ProtocolCodec.encode(ProtocolPacket(
      type: PacketType.pairAccept, data: {}, sessionId: sessionId,
    )));
    await _currentReceiveSocket!.flush();
    _currentIncomingTransfer = _currentIncomingTransfer!.copyWith(status: TransferStatus.transferring);
    _incomingTransferController.add(_currentIncomingTransfer);
  }

  @override
  Future<void> rejectTransfer(String sessionId) async {
    if (_currentIncomingTransfer != null && _currentReceiveSocket != null) {
      logger.w('[Receiver] Sending Deny to peer');
      _currentReceiveSocket!.add(ProtocolCodec.encode(ProtocolPacket(
        type: PacketType.pairDeny, data: {}, sessionId: sessionId,
      )));
      await _currentReceiveSocket!.flush();
    }
    _currentReceiveSink?.close();
    _currentReceiveSink = null;
    if (_tempFilePath != null) {
      final f = File(_tempFilePath!);
      if (f.existsSync()) f.deleteSync();
    }
    _currentIncomingTransfer = null;
    _currentReceiveSocket = null;
    _incomingTransferController.add(null);
  }

  @override
  Future<void> cancelReceive(String sessionId) async {
    if (_currentIncomingTransfer != null && _currentReceiveSocket != null) {
      logger.w('[Receiver] Sending Cancel to peer');
      _currentReceiveSocket!.add(ProtocolCodec.encode(ProtocolPacket(
        type: PacketType.cancel, data: {}, sessionId: sessionId,
      )));
      await _currentReceiveSocket!.flush();
    }
    await _currentReceiveSink?.close();
    _currentReceiveSink = null;
    if (_tempFilePath != null) {
      final f = File(_tempFilePath!);
      if (f.existsSync()) f.deleteSync();
    }
    _currentIncomingTransfer = _currentIncomingTransfer?.copyWith(status: TransferStatus.cancelled);
    _incomingTransferController.add(_currentIncomingTransfer);
  }

  Future<Directory> _getSaveDir() async {
    if (Platform.isAndroid) {
      final dir = Directory('/storage/emulated/0/Download/Miros');
      if (!dir.existsSync()) dir.createSync(recursive: true);
      return dir;
    } else {
      final base = await getDownloadsDirectory() ?? await getTemporaryDirectory();
      final dir = Directory(p.join(base.path, 'Miros'));
      if (!dir.existsSync()) dir.createSync(recursive: true);
      return dir;
    }
  }
}










































