import 'dart:convert';
import 'dart:typed_data';
import '../../domain/entities/protocol_packet.dart';

class DecodeResult {
  final List<ProtocolPacket> packets;
  final Uint8List remaining;

  DecodeResult(this.packets, this.remaining);
}

class ProtocolCodec {
  static const int headerSize = 4; // 4 bytes for length prefix

  static Uint8List encode(ProtocolPacket packet) {
    final jsonString = jsonEncode(packet.toJson());
    final body = utf8.encode(jsonString);
    final length = body.length;
    
    final buffer = BytesBuilder();
    final lengthBytes = ByteData(4)..setUint32(0, length);
    buffer.add(lengthBytes.buffer.asUint8List());
    buffer.add(body);
    
    return buffer.toBytes();
  }

  /// Decodes multiple packets from a byte stream.
  /// Returns a list of decoded packets and any remaining bytes that form a partial packet.
  static DecodeResult decode(Uint8List data) {
    final List<ProtocolPacket> packets = [];
    int offset = 0;

    while (data.length - offset >= headerSize) {
      final view = ByteData.sublistView(data, offset, offset + headerSize);
      final length = view.getUint32(0);
      
      if (data.length - offset < headerSize + length) {
        // Incomplete packet in buffer
        break;
      }
      
      try {
        final body = data.sublist(offset + headerSize, offset + headerSize + length);
        final jsonString = utf8.decode(body);
        final json = jsonDecode(jsonString) as Map<String, dynamic>;
        packets.add(ProtocolPacket.fromJson(json));
      } catch (e) {
        // Skip corrupted packet
      }
      
      offset += headerSize + length;
    }

    return DecodeResult(packets, data.sublist(offset));
  }
}










































