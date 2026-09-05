// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SettingsEntityImpl _$$SettingsEntityImplFromJson(Map<String, dynamic> json) =>
    _$SettingsEntityImpl(
      deviceName: json['deviceName'] as String,
      isVisible: json['isVisible'] as bool? ?? true,
      autoAccept: json['autoAccept'] as bool? ?? false,
      downloadPath: json['downloadPath'] as String? ?? 'Downloads/Miros',
      useDarkMode: json['useDarkMode'] as bool? ?? true,
      themePreset:
          $enumDecodeNullable(_$ThemePresetEnumMap, json['themePreset']) ??
              ThemePreset.neonBlue,
      udpPort: (json['udpPort'] as num?)?.toInt() ?? 53317,
      tcpPort: (json['tcpPort'] as num?)?.toInt() ?? 53318,
    );

Map<String, dynamic> _$$SettingsEntityImplToJson(
        _$SettingsEntityImpl instance) =>
    <String, dynamic>{
      'deviceName': instance.deviceName,
      'isVisible': instance.isVisible,
      'autoAccept': instance.autoAccept,
      'downloadPath': instance.downloadPath,
      'useDarkMode': instance.useDarkMode,
      'themePreset': _$ThemePresetEnumMap[instance.themePreset]!,
      'udpPort': instance.udpPort,
      'tcpPort': instance.tcpPort,
    };

const _$ThemePresetEnumMap = {
  ThemePreset.neonBlue: 'neonBlue',
  ThemePreset.neonPink: 'neonPink',
  ThemePreset.acidGreen: 'acidGreen',
  ThemePreset.solarOrange: 'solarOrange',
};
