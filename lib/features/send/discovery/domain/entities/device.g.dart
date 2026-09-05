// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DiscoveredDeviceImpl _$$DiscoveredDeviceImplFromJson(
        Map<String, dynamic> json) =>
    _$DiscoveredDeviceImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      ip: json['ip'] as String,
      port: (json['port'] as num).toInt(),
      platform: $enumDecode(_$DevicePlatformEnumMap, json['platform']),
      version: json['version'] as String,
      isOnline: json['isOnline'] as bool? ?? true,
      lastSeen: json['lastSeen'] == null
          ? null
          : DateTime.parse(json['lastSeen'] as String),
      isTrusted: json['isTrusted'] as bool? ?? false,
    );

Map<String, dynamic> _$$DiscoveredDeviceImplToJson(
        _$DiscoveredDeviceImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'ip': instance.ip,
      'port': instance.port,
      'platform': _$DevicePlatformEnumMap[instance.platform]!,
      'version': instance.version,
      'isOnline': instance.isOnline,
      'lastSeen': instance.lastSeen?.toIso8601String(),
      'isTrusted': instance.isTrusted,
    };

const _$DevicePlatformEnumMap = {
  DevicePlatform.android: 'android',
  DevicePlatform.windows: 'windows',
  DevicePlatform.linux: 'linux',
  DevicePlatform.macos: 'macos',
  DevicePlatform.ios: 'ios',
  DevicePlatform.unknown: 'unknown',
};
