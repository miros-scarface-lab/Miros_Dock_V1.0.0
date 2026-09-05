import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:miros_share_and_web_dock/features/send/core/config/app_config.dart';
import 'package:miros_share_and_web_dock/features/send/core/utils/logger.dart';
import '../../domain/entities/protocol_packet.dart';
import 'protocol_codec.dart';

class TcpPacketWrapper {
  final ProtocolPacket packet;
  final Socket socket;

  TcpPacketWrapper(this.packet, this.socket);
}

class TcpServerDataSource {
  ServerSocket? _server;
  final _packetController = StreamController<TcpPacketWrapper>.broadcast();
  final Map<Socket, BytesBuilder> _buffers = {};
  
  Stream<TcpPacketWrapper> get packetStream => _packetController.stream;

  Future<void> start() async {
    try {
      _server = await ServerSocket.bind(InternetAddress.anyIPv6, AppConfig.defaultTcpPort, shared: true, v6Only: false);
      _server?.listen((Socket client) {
        client.setOption(SocketOption.tcpNoDelay, true);
        final buffer = BytesBuilder();
        _buffers[client] = buffer;
        
        client.listen(
          (Uint8List data) {
            buffer.add(data);
            final result = ProtocolCodec.decode(buffer.takeBytes());
            
            for (final packet in result.packets) {
              _packetController.add(TcpPacketWrapper(packet, client));
            }
            
            if (result.remaining.isNotEmpty) {
              buffer.add(result.remaining);
            }
          },
          onDone: () {
            _buffers.remove(client);
            client.destroy();
          },
          onError: (e) {
            _buffers.remove(client);
            client.destroy();
          }
        );
      });
      logger.i('TCP Server started on port ${AppConfig.defaultTcpPort}');
    } catch (e) {
      logger.e('Failed to start TCP Server: $e');
    }
  }

  void stop() {
    _server?.close();
    _server = null;
    _buffers.clear();
    logger.i('TCP Server stopped');
  }
}










































