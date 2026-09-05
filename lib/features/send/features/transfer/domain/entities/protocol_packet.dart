import 'package:freezed_annotation/freezed_annotation.dart';

part 'protocol_packet.freezed.dart';
part 'protocol_packet.g.dart';

enum PacketType {
  hello,
  pairRequest,
  pairAccept,
  pairDeny,
  auth,
  fileHeader,
  batchHeader,
  chunk,
  ack,
  nak,
  ping,
  pong,
  complete,
  batchComplete,
  error,
  cancel,
  heartbeat,
}

@freezed
class ProtocolPacket with _$ProtocolPacket {
  const factory ProtocolPacket({
    required PacketType type,
    required Map<String, dynamic> data,
    String? id,
    String? sessionId,
    String? authNonce, // Handshake secret
    @Default(1) int version,
  }) = _ProtocolPacket;

  factory ProtocolPacket.fromJson(Map<String, dynamic> json) =>
      _$ProtocolPacketFromJson(json);
}

@freezed
class BatchMetadata with _$BatchMetadata {
  const factory BatchMetadata({
    required int fileCount,
    required int totalSize,
    required List<FileMetadata> files,
  }) = _BatchMetadata;

  factory BatchMetadata.fromJson(Map<String, dynamic> json) =>
      _$BatchMetadataFromJson(json);
}

@freezed
class FileMetadata with _$FileMetadata {
  const factory FileMetadata({
    required String name,
    required String extension,
    required String mimeType,
    required int size,
    required String sha256,
    required int lastModified,
    required int chunkCount,
    required int chunkSize,
    @Default(false) bool encryptionEnabled,
    @Default(false) bool compressionEnabled,
    String? thumbnail,
  }) = _FileMetadata;

  factory FileMetadata.fromJson(Map<String, dynamic> json) =>
      _$FileMetadataFromJson(json);
}










































