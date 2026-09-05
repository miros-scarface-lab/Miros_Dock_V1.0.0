import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:miros_share_and_web_dock/features/send/core/utils/logger.dart';
import '../../domain/entities/protocol_packet.dart';
import 'protocol_codec.dart';

class TcpClientDataSource {
  Socket? _socket;
  final _packetController = StreamController<ProtocolPacket>.broadcast();
  final _buffer = BytesBuilder();
  
  Stream<ProtocolPacket> get packetStream => _packetController.stream;

  Future<bool> connect(String ip, int port) async {
    try {
      _buffer.clear();
      _socket = await Socket.connect(ip, port, timeout: const Duration(seconds: 10));
      _socket?.listen(
        _onData,
        onError: (e) => logger.e('TCP Client Error: $e'),
        onDone: () => disconnect(),
      );
      return true;
    } catch (e) {
      logger.e('Connection failed: $e');
      return false;
    }
  }

  void _onData(Uint8List data) {
    _buffer.add(data);
    final result = ProtocolCodec.decode(_buffer.takeBytes());
    
    for (final packet in result.packets) {
      _packetController.add(packet);
    }
    
    // Put remaining bytes back in buffer
    if (result.remaining.isNotEmpty) {
      _buffer.add(result.remaining);
    }
  }

  Future<void> sendPacket(ProtocolPacket packet) async {
    if (_socket == null) return;
    _socket?.add(ProtocolCodec.encode(packet));
    await _socket?.flush();
  }

  void disconnect() {
    _socket?.destroy();
    _socket = null;
    _buffer.clear();
  }
}



