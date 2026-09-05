import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:miros_share_and_web_dock/features/send/core/utils/name_generator.dart';

part 'settings.freezed.dart';
part 'settings.g.dart';

@freezed
class SettingsEntity with _$SettingsEntity {
  const factory SettingsEntity({
    required String deviceName,
    @Default(true) bool isVisible,
    @Default(false) bool autoAccept,
    @Default('Downloads/Miros') String downloadPath,
    @Default(true) bool useDarkMode,
    @Default(53317) int udpPort,
    @Default(53318) int tcpPort,
  }) = _SettingsEntity;

  factory SettingsEntity.fromJson(Map<String, dynamic> json) =>
      _$SettingsEntityFromJson(json);

  // Helper to get initial settings with a random name
  static SettingsEntity initial() => SettingsEntity(
    deviceName: CyberNameGenerator.generate(),
  );
}



