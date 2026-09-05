import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../models/server_config.dart';
import '../models/shared_folder.dart';
import '../models/file_item.dart';

class DatabaseService {
  late Isar _isar;

  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open(
      [ServerConfigSchema, SharedFolderSchema, FileItemSchema],
      directory: dir.path,
    );
  }

  Isar get isar => _isar;

  // Shared Folders
  Future<List<SharedFolder>> getAllSharedFolders() async {
    return await _isar.sharedFolders.where().findAll();
  }

  Future<void> addSharedFolder(SharedFolder folder) async {
    await _isar.writeTxn(() async {
      await _isar.sharedFolders.put(folder);
    });
  }

  Future<void> removeSharedFolder(int id) async {
    await _isar.writeTxn(() async {
      await _isar.sharedFolders.delete(id);
    });
  }

  // Server Config
  Future<ServerConfig> getConfig() async {
    final config = await _isar.serverConfigs.get(1);
    if (config == null) {
      final newConfig = ServerConfig()
        ..adminUsername = 'miros'
        ..adminPasswordHash = '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92'; // SHA-256 for 'miros'

      await _isar.writeTxn(() async {
        await _isar.serverConfigs.put(newConfig);
      });
      return newConfig;
    }
    return config;
  }

  Future<void> saveConfig(ServerConfig config) async {
    await _isar.writeTxn(() async {
      await _isar.serverConfigs.put(config);
    });
  }
}






