// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SettingsEntity _$SettingsEntityFromJson(Map<String, dynamic> json) {
  return _SettingsEntity.fromJson(json);
}

/// @nodoc
mixin _$SettingsEntity {
  String get deviceName => throw _privateConstructorUsedError;
  bool get isVisible => throw _privateConstructorUsedError;
  bool get autoAccept => throw _privateConstructorUsedError;
  String get downloadPath => throw _privateConstructorUsedError;
  bool get useDarkMode => throw _privateConstructorUsedError;
  int get udpPort => throw _privateConstructorUsedError;
  int get tcpPort => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SettingsEntityCopyWith<SettingsEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SettingsEntityCopyWith<$Res> {
  factory $SettingsEntityCopyWith(
          SettingsEntity value, $Res Function(SettingsEntity) then) =
      _$SettingsEntityCopyWithImpl<$Res, SettingsEntity>;
  @useResult
  $Res call(
      {String deviceName,
      bool isVisible,
      bool autoAccept,
      String downloadPath,
      bool useDarkMode,
      int udpPort,
      int tcpPort});
}

/// @nodoc
class _$SettingsEntityCopyWithImpl<$Res, $Val extends SettingsEntity>
    implements $SettingsEntityCopyWith<$Res> {
  _$SettingsEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? deviceName = null,
    Object? isVisible = null,
    Object? autoAccept = null,
    Object? downloadPath = null,
    Object? useDarkMode = null,
    Object? udpPort = null,
    Object? tcpPort = null,
  }) {
    return _then(_value.copyWith(
      deviceName: null == deviceName
          ? _value.deviceName
          : deviceName // ignore: cast_nullable_to_non_nullable
              as String,
      isVisible: null == isVisible
          ? _value.isVisible
          : isVisible // ignore: cast_nullable_to_non_nullable
              as bool,
      autoAccept: null == autoAccept
          ? _value.autoAccept
          : autoAccept // ignore: cast_nullable_to_non_nullable
              as bool,
      downloadPath: null == downloadPath
          ? _value.downloadPath
          : downloadPath // ignore: cast_nullable_to_non_nullable
              as String,
      useDarkMode: null == useDarkMode
          ? _value.useDarkMode
          : useDarkMode // ignore: cast_nullable_to_non_nullable
              as bool,
      udpPort: null == udpPort
          ? _value.udpPort
          : udpPort // ignore: cast_nullable_to_non_nullable
              as int,
      tcpPort: null == tcpPort
          ? _value.tcpPort
          : tcpPort // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SettingsEntityImplCopyWith<$Res>
    implements $SettingsEntityCopyWith<$Res> {
  factory _$$SettingsEntityImplCopyWith(_$SettingsEntityImpl value,
          $Res Function(_$SettingsEntityImpl) then) =
      __$$SettingsEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String deviceName,
      bool isVisible,
      bool autoAccept,
      String downloadPath,
      bool useDarkMode,
      int udpPort,
      int tcpPort});
}

/// @nodoc
class __$$SettingsEntityImplCopyWithImpl<$Res>
    extends _$SettingsEntityCopyWithImpl<$Res, _$SettingsEntityImpl>
    implements _$$SettingsEntityImplCopyWith<$Res> {
  __$$SettingsEntityImplCopyWithImpl(
      _$SettingsEntityImpl _value, $Res Function(_$SettingsEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? deviceName = null,
    Object? isVisible = null,
    Object? autoAccept = null,
    Object? downloadPath = null,
    Object? useDarkMode = null,
    Object? udpPort = null,
    Object? tcpPort = null,
  }) {
    return _then(_$SettingsEntityImpl(
      deviceName: null == deviceName
          ? _value.deviceName
          : deviceName // ignore: cast_nullable_to_non_nullable
              as String,
      isVisible: null == isVisible
          ? _value.isVisible
          : isVisible // ignore: cast_nullable_to_non_nullable
              as bool,
      autoAccept: null == autoAccept
          ? _value.autoAccept
          : autoAccept // ignore: cast_nullable_to_non_nullable
              as bool,
      downloadPath: null == downloadPath
          ? _value.downloadPath
          : downloadPath // ignore: cast_nullable_to_non_nullable
              as String,
      useDarkMode: null == useDarkMode
          ? _value.useDarkMode
          : useDarkMode // ignore: cast_nullable_to_non_nullable
              as bool,
      udpPort: null == udpPort
          ? _value.udpPort
          : udpPort // ignore: cast_nullable_to_non_nullable
              as int,
      tcpPort: null == tcpPort
          ? _value.tcpPort
          : tcpPort // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SettingsEntityImpl implements _SettingsEntity {
  const _$SettingsEntityImpl(
      {required this.deviceName,
      this.isVisible = true,
      this.autoAccept = false,
      this.downloadPath = 'Downloads/Miros',
      this.useDarkMode = true,
      this.udpPort = 53317,
      this.tcpPort = 53318});

  factory _$SettingsEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$SettingsEntityImplFromJson(json);

  @override
  final String deviceName;
  @override
  @JsonKey()
  final bool isVisible;
  @override
  @JsonKey()
  final bool autoAccept;
  @override
  @JsonKey()
  final String downloadPath;
  @override
  @JsonKey()
  final bool useDarkMode;
  @override
  @JsonKey()
  final int udpPort;
  @override
  @JsonKey()
  final int tcpPort;

  @override
  String toString() {
    return 'SettingsEntity(deviceName: $deviceName, isVisible: $isVisible, autoAccept: $autoAccept, downloadPath: $downloadPath, useDarkMode: $useDarkMode, udpPort: $udpPort, tcpPort: $tcpPort)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SettingsEntityImpl &&
            (identical(other.deviceName, deviceName) ||
                other.deviceName == deviceName) &&
            (identical(other.isVisible, isVisible) ||
                other.isVisible == isVisible) &&
            (identical(other.autoAccept, autoAccept) ||
                other.autoAccept == autoAccept) &&
            (identical(other.downloadPath, downloadPath) ||
                other.downloadPath == downloadPath) &&
            (identical(other.useDarkMode, useDarkMode) ||
                other.useDarkMode == useDarkMode) &&
            (identical(other.udpPort, udpPort) || other.udpPort == udpPort) &&
            (identical(other.tcpPort, tcpPort) || other.tcpPort == tcpPort));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, deviceName, isVisible,
      autoAccept, downloadPath, useDarkMode, udpPort, tcpPort);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SettingsEntityImplCopyWith<_$SettingsEntityImpl> get copyWith =>
      __$$SettingsEntityImplCopyWithImpl<_$SettingsEntityImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SettingsEntityImplToJson(
      this,
    );
  }
}

abstract class _SettingsEntity implements SettingsEntity {
  const factory _SettingsEntity(
      {required final String deviceName,
      final bool isVisible,
      final bool autoAccept,
      final String downloadPath,
      final bool useDarkMode,
      final int udpPort,
      final int tcpPort}) = _$SettingsEntityImpl;

  factory _SettingsEntity.fromJson(Map<String, dynamic> json) =
      _$SettingsEntityImpl.fromJson;

  @override
  String get deviceName;
  @override
  bool get isVisible;
  @override
  bool get autoAccept;
  @override
  String get downloadPath;
  @override
  bool get useDarkMode;
  @override
  int get udpPort;
  @override
  int get tcpPort;
  @override
  @JsonKey(ignore: true)
  _$$SettingsEntityImplCopyWith<_$SettingsEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
