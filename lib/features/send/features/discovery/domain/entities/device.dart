import 'package:freezed_annotation/freezed_annotation.dart';

part 'device.freezed.dart';
part 'device.g.dart';

enum DevicePlatform {
  android,
  windows,
  linux,
  macos,
  ios,
  unknown;

  static DevicePlatform fromString(String value) {
    return DevicePlatform.values.firstWhere(
      (e) => e.name == value.toLowerCase(),
      orElse: () => DevicePlatform.unknown,
    );
  }
}

@freezed
class DiscoveredDevice with _$DiscoveredDevice {
  const factory DiscoveredDevice({
    required String id,
    required String name,
    required String ip, // Primary IP (backward compatibility)
    @Default([]) List<String> ips, // List of all local IPs
    required int port,
    required DevicePlatform platform,
    required String version,
    @Default(true) bool isOnline,
    DateTime? lastSeen,
    @Default(false) bool isTrusted,
  }) = _DiscoveredDevice;

  factory DiscoveredDevice.fromJson(Map<String, dynamic> json) =>
      _$DiscoveredDeviceFromJson(json);
}










































