// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'protocol_packet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProtocolPacketImpl _$$ProtocolPacketImplFromJson(Map<String, dynamic> json) =>
    _$ProtocolPacketImpl(
      type: $enumDecode(_$PacketTypeEnumMap, json['type']),
      data: json['data'] as Map<String, dynamic>,
      id: json['id'] as String?,
      sessionId: json['sessionId'] as String?,
      authNonce: json['authNonce'] as String?,
      version: (json['version'] as num?)?.toInt() ?? 1,
    );

Map<String, dynamic> _$$ProtocolPacketImplToJson(
        _$ProtocolPacketImpl instance) =>
    <String, dynamic>{
      'type': _$PacketTypeEnumMap[instance.type]!,
      'data': instance.data,
      'id': instance.id,
      'sessionId': instance.sessionId,
      'authNonce': instance.authNonce,
      'version': instance.version,
    };

const _$PacketTypeEnumMap = {
  PacketType.hello: 'hello',
  PacketType.pairRequest: 'pairRequest',
  PacketType.pairAccept: 'pairAccept',
  PacketType.pairDeny: 'pairDeny',
  PacketType.auth: 'auth',
  PacketType.fileHeader: 'fileHeader',
  PacketType.batchHeader: 'batchHeader',
  PacketType.chunk: 'chunk',
  PacketType.ack: 'ack',
  PacketType.nak: 'nak',
  PacketType.ping: 'ping',
  PacketType.pong: 'pong',
  PacketType.complete: 'complete',
  PacketType.batchComplete: 'batchComplete',
  PacketType.error: 'error',
  PacketType.cancel: 'cancel',
  PacketType.heartbeat: 'heartbeat',
};

_$BatchMetadataImpl _$$BatchMetadataImplFromJson(Map<String, dynamic> json) =>
    _$BatchMetadataImpl(
      fileCount: (json['fileCount'] as num).toInt(),
      totalSize: (json['totalSize'] as num).toInt(),
      files: (json['files'] as List<dynamic>)
          .map((e) => FileMetadata.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$BatchMetadataImplToJson(_$BatchMetadataImpl instance) =>
    <String, dynamic>{
      'fileCount': instance.fileCount,
      'totalSize': instance.totalSize,
      'files': instance.files,
    };

_$FileMetadataImpl _$$FileMetadataImplFromJson(Map<String, dynamic> json) =>
    _$FileMetadataImpl(
      name: json['name'] as String,
      extension: json['extension'] as String,
      mimeType: json['mimeType'] as String,
      size: (json['size'] as num).toInt(),
      sha256: json['sha256'] as String,
      lastModified: (json['lastModified'] as num).toInt(),
      chunkCount: (json['chunkCount'] as num).toInt(),
      chunkSize: (json['chunkSize'] as num).toInt(),
      encryptionEnabled: json['encryptionEnabled'] as bool? ?? false,
      compressionEnabled: json['compressionEnabled'] as bool? ?? false,
      thumbnail: json['thumbnail'] as String?,
    );

Map<String, dynamic> _$$FileMetadataImplToJson(_$FileMetadataImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'extension': instance.extension,
      'mimeType': instance.mimeType,
      'size': instance.size,
      'sha256': instance.sha256,
      'lastModified': instance.lastModified,
      'chunkCount': instance.chunkCount,
      'chunkSize': instance.chunkSize,
      'encryptionEnabled': instance.encryptionEnabled,
      'compressionEnabled': instance.compressionEnabled,
      'thumbnail': instance.thumbnail,
    };
