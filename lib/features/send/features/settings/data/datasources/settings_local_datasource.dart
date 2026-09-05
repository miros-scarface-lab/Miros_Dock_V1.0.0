import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:miros_share_and_web_dock/features/send/core/config/app_config.dart';
import '../../domain/entities/settings.dart';

class SettingsLocalDataSource {
  static const String _key = 'app_settings';
  
  Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(AppConfig.hiveBoxSettings);
  }

  SettingsEntity getSettings() {
    final box = Hive.box(AppConfig.hiveBoxSettings);
    final data = box.get(_key);
    
    if (data == null) {
      final initial = SettingsEntity.initial();
      saveSettings(initial);
      return initial;
    }
    
    return SettingsEntity.fromJson(Map<String, dynamic>.from(jsonDecode(data)));
  }

  Future<void> saveSettings(SettingsEntity settings) async {
    final box = Hive.box(AppConfig.hiveBoxSettings);
    await box.put(_key, jsonEncode(settings.toJson()));
  }
}










































