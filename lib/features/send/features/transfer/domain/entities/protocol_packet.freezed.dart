// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'protocol_packet.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProtocolPacket _$ProtocolPacketFromJson(Map<String, dynamic> json) {
  return _ProtocolPacket.fromJson(json);
}

/// @nodoc
mixin _$ProtocolPacket {
  PacketType get type => throw _privateConstructorUsedError;
  Map<String, dynamic> get data => throw _privateConstructorUsedError;
  String? get id => throw _privateConstructorUsedError;
  String? get sessionId => throw _privateConstructorUsedError;
  String? get authNonce =>
      throw _privateConstructorUsedError; // Handshake secret
  int get version => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProtocolPacketCopyWith<ProtocolPacket> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProtocolPacketCopyWith<$Res> {
  factory $ProtocolPacketCopyWith(
          ProtocolPacket value, $Res Function(ProtocolPacket) then) =
      _$ProtocolPacketCopyWithImpl<$Res, ProtocolPacket>;
  @useResult
  $Res call(
      {PacketType type,
      Map<String, dynamic> data,
      String? id,
      String? sessionId,
      String? authNonce,
      int version});
}

/// @nodoc
class _$ProtocolPacketCopyWithImpl<$Res, $Val extends ProtocolPacket>
    implements $ProtocolPacketCopyWith<$Res> {
  _$ProtocolPacketCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? data = null,
    Object? id = freezed,
    Object? sessionId = freezed,
    Object? authNonce = freezed,
    Object? version = null,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as PacketType,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      sessionId: freezed == sessionId
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String?,
      authNonce: freezed == authNonce
          ? _value.authNonce
          : authNonce // ignore: cast_nullable_to_non_nullable
              as String?,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProtocolPacketImplCopyWith<$Res>
    implements $ProtocolPacketCopyWith<$Res> {
  factory _$$ProtocolPacketImplCopyWith(_$ProtocolPacketImpl value,
          $Res Function(_$ProtocolPacketImpl) then) =
      __$$ProtocolPacketImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {PacketType type,
      Map<String, dynamic> data,
      String? id,
      String? sessionId,
      String? authNonce,
      int version});
}

/// @nodoc
class __$$ProtocolPacketImplCopyWithImpl<$Res>
    extends _$ProtocolPacketCopyWithImpl<$Res, _$ProtocolPacketImpl>
    implements _$$ProtocolPacketImplCopyWith<$Res> {
  __$$ProtocolPacketImplCopyWithImpl(
      _$ProtocolPacketImpl _value, $Res Function(_$ProtocolPacketImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? data = null,
    Object? id = freezed,
    Object? sessionId = freezed,
    Object? authNonce = freezed,
    Object? version = null,
  }) {
    return _then(_$ProtocolPacketImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as PacketType,
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      sessionId: freezed == sessionId
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String?,
      authNonce: freezed == authNonce
          ? _value.authNonce
          : authNonce // ignore: cast_nullable_to_non_nullable
              as String?,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProtocolPacketImpl implements _ProtocolPacket {
  const _$ProtocolPacketImpl(
      {required this.type,
      required final Map<String, dynamic> data,
      this.id,
      this.sessionId,
      this.authNonce,
      this.version = 1})
      : _data = data;

  factory _$ProtocolPacketImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProtocolPacketImplFromJson(json);

  @override
  final PacketType type;
  final Map<String, dynamic> _data;
  @override
  Map<String, dynamic> get data {
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_data);
  }

  @override
  final String? id;
  @override
  final String? sessionId;
  @override
  final String? authNonce;
// Handshake secret
  @override
  @JsonKey()
  final int version;

  @override
  String toString() {
    return 'ProtocolPacket(type: $type, data: $data, id: $id, sessionId: $sessionId, authNonce: $authNonce, version: $version)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProtocolPacketImpl &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.sessionId, sessionId) ||
                other.sessionId == sessionId) &&
            (identical(other.authNonce, authNonce) ||
                other.authNonce == authNonce) &&
            (identical(other.version, version) || other.version == version));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      type,
      const DeepCollectionEquality().hash(_data),
      id,
      sessionId,
      authNonce,
      version);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProtocolPacketImplCopyWith<_$ProtocolPacketImpl> get copyWith =>
      __$$ProtocolPacketImplCopyWithImpl<_$ProtocolPacketImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProtocolPacketImplToJson(
      this,
    );
  }
}

abstract class _ProtocolPacket implements ProtocolPacket {
  const factory _ProtocolPacket(
      {required final PacketType type,
      required final Map<String, dynamic> data,
      final String? id,
      final String? sessionId,
      final String? authNonce,
      final int version}) = _$ProtocolPacketImpl;

  factory _ProtocolPacket.fromJson(Map<String, dynamic> json) =
      _$ProtocolPacketImpl.fromJson;

  @override
  PacketType get type;
  @override
  Map<String, dynamic> get data;
  @override
  String? get id;
  @override
  String? get sessionId;
  @override
  String? get authNonce;
  @override // Handshake secret
  int get version;
  @override
  @JsonKey(ignore: true)
  _$$ProtocolPacketImplCopyWith<_$ProtocolPacketImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BatchMetadata _$BatchMetadataFromJson(Map<String, dynamic> json) {
  return _BatchMetadata.fromJson(json);
}

/// @nodoc
mixin _$BatchMetadata {
  int get fileCount => throw _privateConstructorUsedError;
  int get totalSize => throw _privateConstructorUsedError;
  List<FileMetadata> get files => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BatchMetadataCopyWith<BatchMetadata> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BatchMetadataCopyWith<$Res> {
  factory $BatchMetadataCopyWith(
          BatchMetadata value, $Res Function(BatchMetadata) then) =
      _$BatchMetadataCopyWithImpl<$Res, BatchMetadata>;
  @useResult
  $Res call({int fileCount, int totalSize, List<FileMetadata> files});
}

/// @nodoc
class _$BatchMetadataCopyWithImpl<$Res, $Val extends BatchMetadata>
    implements $BatchMetadataCopyWith<$Res> {
  _$BatchMetadataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fileCount = null,
    Object? totalSize = null,
    Object? files = null,
  }) {
    return _then(_value.copyWith(
      fileCount: null == fileCount
          ? _value.fileCount
          : fileCount // ignore: cast_nullable_to_non_nullable
              as int,
      totalSize: null == totalSize
          ? _value.totalSize
          : totalSize // ignore: cast_nullable_to_non_nullable
              as int,
      files: null == files
          ? _value.files
          : files // ignore: cast_nullable_to_non_nullable
              as List<FileMetadata>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BatchMetadataImplCopyWith<$Res>
    implements $BatchMetadataCopyWith<$Res> {
  factory _$$BatchMetadataImplCopyWith(
          _$BatchMetadataImpl value, $Res Function(_$BatchMetadataImpl) then) =
      __$$BatchMetadataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int fileCount, int totalSize, List<FileMetadata> files});
}

/// @nodoc
class __$$BatchMetadataImplCopyWithImpl<$Res>
    extends _$BatchMetadataCopyWithImpl<$Res, _$BatchMetadataImpl>
    implements _$$BatchMetadataImplCopyWith<$Res> {
  __$$BatchMetadataImplCopyWithImpl(
      _$BatchMetadataImpl _value, $Res Function(_$BatchMetadataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fileCount = null,
    Object? totalSize = null,
    Object? files = null,
  }) {
    return _then(_$BatchMetadataImpl(
      fileCount: null == fileCount
          ? _value.fileCount
          : fileCount // ignore: cast_nullable_to_non_nullable
              as int,
      totalSize: null == totalSize
          ? _value.totalSize
          : totalSize // ignore: cast_nullable_to_non_nullable
              as int,
      files: null == files
          ? _value._files
          : files // ignore: cast_nullable_to_non_nullable
              as List<FileMetadata>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BatchMetadataImpl implements _BatchMetadata {
  const _$BatchMetadataImpl(
      {required this.fileCount,
      required this.totalSize,
      required final List<FileMetadata> files})
      : _files = files;

  factory _$BatchMetadataImpl.fromJson(Map<String, dynamic> json) =>
      _$$BatchMetadataImplFromJson(json);

  @override
  final int fileCount;
  @override
  final int totalSize;
  final List<FileMetadata> _files;
  @override
  List<FileMetadata> get files {
    if (_files is EqualUnmodifiableListView) return _files;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_files);
  }

  @override
  String toString() {
    return 'BatchMetadata(fileCount: $fileCount, totalSize: $totalSize, files: $files)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BatchMetadataImpl &&
            (identical(other.fileCount, fileCount) ||
                other.fileCount == fileCount) &&
            (identical(other.totalSize, totalSize) ||
                other.totalSize == totalSize) &&
            const DeepCollectionEquality().equals(other._files, _files));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, fileCount, totalSize,
      const DeepCollectionEquality().hash(_files));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BatchMetadataImplCopyWith<_$BatchMetadataImpl> get copyWith =>
      __$$BatchMetadataImplCopyWithImpl<_$BatchMetadataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BatchMetadataImplToJson(
      this,
    );
  }
}

abstract class _BatchMetadata implements BatchMetadata {
  const factory _BatchMetadata(
      {required final int fileCount,
      required final int totalSize,
      required final List<FileMetadata> files}) = _$BatchMetadataImpl;

  factory _BatchMetadata.fromJson(Map<String, dynamic> json) =
      _$BatchMetadataImpl.fromJson;

  @override
  int get fileCount;
  @override
  int get totalSize;
  @override
  List<FileMetadata> get files;
  @override
  @JsonKey(ignore: true)
  _$$BatchMetadataImplCopyWith<_$BatchMetadataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FileMetadata _$FileMetadataFromJson(Map<String, dynamic> json) {
  return _FileMetadata.fromJson(json);
}

/// @nodoc
mixin _$FileMetadata {
  String get name => throw _privateConstructorUsedError;
  String get extension => throw _privateConstructorUsedError;
  String get mimeType => throw _privateConstructorUsedError;
  int get size => throw _privateConstructorUsedError;
  String get sha256 => throw _privateConstructorUsedError;
  int get lastModified => throw _privateConstructorUsedError;
  int get chunkCount => throw _privateConstructorUsedError;
  int get chunkSize => throw _privateConstructorUsedError;
  bool get encryptionEnabled => throw _privateConstructorUsedError;
  bool get compressionEnabled => throw _privateConstructorUsedError;
  String? get thumbnail => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FileMetadataCopyWith<FileMetadata> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FileMetadataCopyWith<$Res> {
  factory $FileMetadataCopyWith(
          FileMetadata value, $Res Function(FileMetadata) then) =
      _$FileMetadataCopyWithImpl<$Res, FileMetadata>;
  @useResult
  $Res call(
      {String name,
      String extension,
      String mimeType,
      int size,
      String sha256,
      int lastModified,
      int chunkCount,
      int chunkSize,
      bool encryptionEnabled,
      bool compressionEnabled,
      String? thumbnail});
}

/// @nodoc
class _$FileMetadataCopyWithImpl<$Res, $Val extends FileMetadata>
    implements $FileMetadataCopyWith<$Res> {
  _$FileMetadataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? extension = null,
    Object? mimeType = null,
    Object? size = null,
    Object? sha256 = null,
    Object? lastModified = null,
    Object? chunkCount = null,
    Object? chunkSize = null,
    Object? encryptionEnabled = null,
    Object? compressionEnabled = null,
    Object? thumbnail = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      extension: null == extension
          ? _value.extension
          : extension // ignore: cast_nullable_to_non_nullable
              as String,
      mimeType: null == mimeType
          ? _value.mimeType
          : mimeType // ignore: cast_nullable_to_non_nullable
              as String,
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as int,
      sha256: null == sha256
          ? _value.sha256
          : sha256 // ignore: cast_nullable_to_non_nullable
              as String,
      lastModified: null == lastModified
          ? _value.lastModified
          : lastModified // ignore: cast_nullable_to_non_nullable
              as int,
      chunkCount: null == chunkCount
          ? _value.chunkCount
          : chunkCount // ignore: cast_nullable_to_non_nullable
              as int,
      chunkSize: null == chunkSize
          ? _value.chunkSize
          : chunkSize // ignore: cast_nullable_to_non_nullable
              as int,
      encryptionEnabled: null == encryptionEnabled
          ? _value.encryptionEnabled
          : encryptionEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      compressionEnabled: null == compressionEnabled
          ? _value.compressionEnabled
          : compressionEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      thumbnail: freezed == thumbnail
          ? _value.thumbnail
          : thumbnail // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FileMetadataImplCopyWith<$Res>
    implements $FileMetadataCopyWith<$Res> {
  factory _$$FileMetadataImplCopyWith(
          _$FileMetadataImpl value, $Res Function(_$FileMetadataImpl) then) =
      __$$FileMetadataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String extension,
      String mimeType,
      int size,
      String sha256,
      int lastModified,
      int chunkCount,
      int chunkSize,
      bool encryptionEnabled,
      bool compressionEnabled,
      String? thumbnail});
}

/// @nodoc
class __$$FileMetadataImplCopyWithImpl<$Res>
    extends _$FileMetadataCopyWithImpl<$Res, _$FileMetadataImpl>
    implements _$$FileMetadataImplCopyWith<$Res> {
  __$$FileMetadataImplCopyWithImpl(
      _$FileMetadataImpl _value, $Res Function(_$FileMetadataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? extension = null,
    Object? mimeType = null,
    Object? size = null,
    Object? sha256 = null,
    Object? lastModified = null,
    Object? chunkCount = null,
    Object? chunkSize = null,
    Object? encryptionEnabled = null,
    Object? compressionEnabled = null,
    Object? thumbnail = freezed,
  }) {
    return _then(_$FileMetadataImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      extension: null == extension
          ? _value.extension
          : extension // ignore: cast_nullable_to_non_nullable
              as String,
      mimeType: null == mimeType
          ? _value.mimeType
          : mimeType // ignore: cast_nullable_to_non_nullable
              as String,
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as int,
      sha256: null == sha256
          ? _value.sha256
          : sha256 // ignore: cast_nullable_to_non_nullable
              as String,
      lastModified: null == lastModified
          ? _value.lastModified
          : lastModified // ignore: cast_nullable_to_non_nullable
              as int,
      chunkCount: null == chunkCount
          ? _value.chunkCount
          : chunkCount // ignore: cast_nullable_to_non_nullable
              as int,
      chunkSize: null == chunkSize
          ? _value.chunkSize
          : chunkSize // ignore: cast_nullable_to_non_nullable
              as int,
      encryptionEnabled: null == encryptionEnabled
          ? _value.encryptionEnabled
          : encryptionEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      compressionEnabled: null == compressionEnabled
          ? _value.compressionEnabled
          : compressionEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      thumbnail: freezed == thumbnail
          ? _value.thumbnail
          : thumbnail // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FileMetadataImpl implements _FileMetadata {
  const _$FileMetadataImpl(
      {required this.name,
      required this.extension,
      required this.mimeType,
      required this.size,
      required this.sha256,
      required this.lastModified,
      required this.chunkCount,
      required this.chunkSize,
      this.encryptionEnabled = false,
      this.compressionEnabled = false,
      this.thumbnail});

  factory _$FileMetadataImpl.fromJson(Map<String, dynamic> json) =>
      _$$FileMetadataImplFromJson(json);

  @override
  final String name;
  @override
  final String extension;
  @override
  final String mimeType;
  @override
  final int size;
  @override
  final String sha256;
  @override
  final int lastModified;
  @override
  final int chunkCount;
  @override
  final int chunkSize;
  @override
  @JsonKey()
  final bool encryptionEnabled;
  @override
  @JsonKey()
  final bool compressionEnabled;
  @override
  final String? thumbnail;

  @override
  String toString() {
    return 'FileMetadata(name: $name, extension: $extension, mimeType: $mimeType, size: $size, sha256: $sha256, lastModified: $lastModified, chunkCount: $chunkCount, chunkSize: $chunkSize, encryptionEnabled: $encryptionEnabled, compressionEnabled: $compressionEnabled, thumbnail: $thumbnail)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FileMetadataImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.extension, extension) ||
                other.extension == extension) &&
            (identical(other.mimeType, mimeType) ||
                other.mimeType == mimeType) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.sha256, sha256) || other.sha256 == sha256) &&
            (identical(other.lastModified, lastModified) ||
                other.lastModified == lastModified) &&
            (identical(other.chunkCount, chunkCount) ||
                other.chunkCount == chunkCount) &&
            (identical(other.chunkSize, chunkSize) ||
                other.chunkSize == chunkSize) &&
            (identical(other.encryptionEnabled, encryptionEnabled) ||
                other.encryptionEnabled == encryptionEnabled) &&
            (identical(other.compressionEnabled, compressionEnabled) ||
                other.compressionEnabled == compressionEnabled) &&
            (identical(other.thumbnail, thumbnail) ||
                other.thumbnail == thumbnail));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      extension,
      mimeType,
      size,
      sha256,
      lastModified,
      chunkCount,
      chunkSize,
      encryptionEnabled,
      compressionEnabled,
      thumbnail);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FileMetadataImplCopyWith<_$FileMetadataImpl> get copyWith =>
      __$$FileMetadataImplCopyWithImpl<_$FileMetadataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FileMetadataImplToJson(
      this,
    );
  }
}

abstract class _FileMetadata implements FileMetadata {
  const factory _FileMetadata(
      {required final String name,
      required final String extension,
      required final String mimeType,
      required final int size,
      required final String sha256,
      required final int lastModified,
      required final int chunkCount,
      required final int chunkSize,
      final bool encryptionEnabled,
      final bool compressionEnabled,
      final String? thumbnail}) = _$FileMetadataImpl;

  factory _FileMetadata.fromJson(Map<String, dynamic> json) =
      _$FileMetadataImpl.fromJson;

  @override
  String get name;
  @override
  String get extension;
  @override
  String get mimeType;
  @override
  int get size;
  @override
  String get sha256;
  @override
  int get lastModified;
  @override
  int get chunkCount;
  @override
  int get chunkSize;
  @override
  bool get encryptionEnabled;
  @override
  bool get compressionEnabled;
  @override
  String? get thumbnail;
  @override
  @JsonKey(ignore: true)
  _$$FileMetadataImplCopyWith<_$FileMetadataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
