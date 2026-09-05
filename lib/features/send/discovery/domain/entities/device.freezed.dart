// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'device.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DiscoveredDevice _$DiscoveredDeviceFromJson(Map<String, dynamic> json) {
  return _DiscoveredDevice.fromJson(json);
}

/// @nodoc
mixin _$DiscoveredDevice {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get ip => throw _privateConstructorUsedError;
  int get port => throw _privateConstructorUsedError;
  DevicePlatform get platform => throw _privateConstructorUsedError;
  String get version => throw _privateConstructorUsedError;
  bool get isOnline => throw _privateConstructorUsedError;
  DateTime? get lastSeen => throw _privateConstructorUsedError;
  bool get isTrusted => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DiscoveredDeviceCopyWith<DiscoveredDevice> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DiscoveredDeviceCopyWith<$Res> {
  factory $DiscoveredDeviceCopyWith(
          DiscoveredDevice value, $Res Function(DiscoveredDevice) then) =
      _$DiscoveredDeviceCopyWithImpl<$Res, DiscoveredDevice>;
  @useResult
  $Res call(
      {String id,
      String name,
      String ip,
      int port,
      DevicePlatform platform,
      String version,
      bool isOnline,
      DateTime? lastSeen,
      bool isTrusted});
}

/// @nodoc
class _$DiscoveredDeviceCopyWithImpl<$Res, $Val extends DiscoveredDevice>
    implements $DiscoveredDeviceCopyWith<$Res> {
  _$DiscoveredDeviceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? ip = null,
    Object? port = null,
    Object? platform = null,
    Object? version = null,
    Object? isOnline = null,
    Object? lastSeen = freezed,
    Object? isTrusted = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      ip: null == ip
          ? _value.ip
          : ip // ignore: cast_nullable_to_non_nullable
              as String,
      port: null == port
          ? _value.port
          : port // ignore: cast_nullable_to_non_nullable
              as int,
      platform: null == platform
          ? _value.platform
          : platform // ignore: cast_nullable_to_non_nullable
              as DevicePlatform,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String,
      isOnline: null == isOnline
          ? _value.isOnline
          : isOnline // ignore: cast_nullable_to_non_nullable
              as bool,
      lastSeen: freezed == lastSeen
          ? _value.lastSeen
          : lastSeen // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isTrusted: null == isTrusted
          ? _value.isTrusted
          : isTrusted // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DiscoveredDeviceImplCopyWith<$Res>
    implements $DiscoveredDeviceCopyWith<$Res> {
  factory _$$DiscoveredDeviceImplCopyWith(_$DiscoveredDeviceImpl value,
          $Res Function(_$DiscoveredDeviceImpl) then) =
      __$$DiscoveredDeviceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String ip,
      int port,
      DevicePlatform platform,
      String version,
      bool isOnline,
      DateTime? lastSeen,
      bool isTrusted});
}

/// @nodoc
class __$$DiscoveredDeviceImplCopyWithImpl<$Res>
    extends _$DiscoveredDeviceCopyWithImpl<$Res, _$DiscoveredDeviceImpl>
    implements _$$DiscoveredDeviceImplCopyWith<$Res> {
  __$$DiscoveredDeviceImplCopyWithImpl(_$DiscoveredDeviceImpl _value,
      $Res Function(_$DiscoveredDeviceImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? ip = null,
    Object? port = null,
    Object? platform = null,
    Object? version = null,
    Object? isOnline = null,
    Object? lastSeen = freezed,
    Object? isTrusted = null,
  }) {
    return _then(_$DiscoveredDeviceImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      ip: null == ip
          ? _value.ip
          : ip // ignore: cast_nullable_to_non_nullable
              as String,
      port: null == port
          ? _value.port
          : port // ignore: cast_nullable_to_non_nullable
              as int,
      platform: null == platform
          ? _value.platform
          : platform // ignore: cast_nullable_to_non_nullable
              as DevicePlatform,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String,
      isOnline: null == isOnline
          ? _value.isOnline
          : isOnline // ignore: cast_nullable_to_non_nullable
              as bool,
      lastSeen: freezed == lastSeen
          ? _value.lastSeen
          : lastSeen // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isTrusted: null == isTrusted
          ? _value.isTrusted
          : isTrusted // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DiscoveredDeviceImpl implements _DiscoveredDevice {
  const _$DiscoveredDeviceImpl(
      {required this.id,
      required this.name,
      required this.ip,
      required this.port,
      required this.platform,
      required this.version,
      this.isOnline = true,
      this.lastSeen,
      this.isTrusted = false});

  factory _$DiscoveredDeviceImpl.fromJson(Map<String, dynamic> json) =>
      _$$DiscoveredDeviceImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String ip;
  @override
  final int port;
  @override
  final DevicePlatform platform;
  @override
  final String version;
  @override
  @JsonKey()
  final bool isOnline;
  @override
  final DateTime? lastSeen;
  @override
  @JsonKey()
  final bool isTrusted;

  @override
  String toString() {
    return 'DiscoveredDevice(id: $id, name: $name, ip: $ip, port: $port, platform: $platform, version: $version, isOnline: $isOnline, lastSeen: $lastSeen, isTrusted: $isTrusted)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DiscoveredDeviceImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.ip, ip) || other.ip == ip) &&
            (identical(other.port, port) || other.port == port) &&
            (identical(other.platform, platform) ||
                other.platform == platform) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.isOnline, isOnline) ||
                other.isOnline == isOnline) &&
            (identical(other.lastSeen, lastSeen) ||
                other.lastSeen == lastSeen) &&
            (identical(other.isTrusted, isTrusted) ||
                other.isTrusted == isTrusted));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, ip, port, platform,
      version, isOnline, lastSeen, isTrusted);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DiscoveredDeviceImplCopyWith<_$DiscoveredDeviceImpl> get copyWith =>
      __$$DiscoveredDeviceImplCopyWithImpl<_$DiscoveredDeviceImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DiscoveredDeviceImplToJson(
      this,
    );
  }
}

abstract class _DiscoveredDevice implements DiscoveredDevice {
  const factory _DiscoveredDevice(
      {required final String id,
      required final String name,
      required final String ip,
      required final int port,
      required final DevicePlatform platform,
      required final String version,
      final bool isOnline,
      final DateTime? lastSeen,
      final bool isTrusted}) = _$DiscoveredDeviceImpl;

  factory _DiscoveredDevice.fromJson(Map<String, dynamic> json) =
      _$DiscoveredDeviceImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get ip;
  @override
  int get port;
  @override
  DevicePlatform get platform;
  @override
  String get version;
  @override
  bool get isOnline;
  @override
  DateTime? get lastSeen;
  @override
  bool get isTrusted;
  @override
  @JsonKey(ignore: true)
  _$$DiscoveredDeviceImplCopyWith<_$DiscoveredDeviceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
