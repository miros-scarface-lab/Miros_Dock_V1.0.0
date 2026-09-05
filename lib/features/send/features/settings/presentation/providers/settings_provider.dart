import 'package:miros_share_and_web_dock/features/send/features/settings/domain/entities/settings.dart';
import 'package:miros_share_and_web_dock/features/send/features/settings/data/datasources/settings_local_datasource.dart';
import 'package:miros_share_and_web_dock/features/send/features/settings/data/repositories/settings_repository_impl.dart';
import 'package:miros_share_and_web_dock/features/send/features/settings/domain/repositories/settings_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings_provider.g.dart';

@riverpod
SettingsRepository settingsRepository(SettingsRepositoryRef ref) {
  return SettingsRepositoryImpl(SettingsLocalDataSource());
}

@riverpod
class Settings extends _$Settings {
  @override
  SettingsEntity build() {
    return ref.watch(settingsRepositoryProvider).getSettings();
  }

  Future<void> updateSettings(SettingsEntity newSettings) async {
    state = newSettings;
    await ref.read(settingsRepositoryProvider).saveSettings(newSettings);
  }

  Future<void> toggleVisibility(bool visible) async {
    await updateSettings(state.copyWith(isVisible: visible));
  }

  Future<void> setDeviceName(String name) async {
    await updateSettings(state.copyWith(deviceName: name));
  }
}










































