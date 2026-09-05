import '../entities/settings.dart';

abstract class SettingsRepository {
  SettingsEntity getSettings();
  Future<void> saveSettings(SettingsEntity settings);
  Future<void> init();
}










































