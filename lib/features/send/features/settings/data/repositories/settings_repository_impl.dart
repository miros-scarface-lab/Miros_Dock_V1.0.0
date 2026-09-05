import '../../domain/entities/settings.dart';
import '../../domain/repositories/settings_repository.dart';
import '../datasources/settings_local_datasource.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsLocalDataSource _localDataSource;

  SettingsRepositoryImpl(this._localDataSource);

  @override
  SettingsEntity getSettings() {
    return _localDataSource.getSettings();
  }

  @override
  Future<void> saveSettings(SettingsEntity settings) {
    return _localDataSource.saveSettings(settings);
  }

  @override
  Future<void> init() {
    return _localDataSource.init();
  }
}










































