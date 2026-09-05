import 'dart:io';
import 'package:path/path.dart' as p;
import '../data/database/database_service.dart';
import '../data/models/shared_folder.dart';
import 'security_service.dart';
import '../indexing/indexer_service.dart';

class FileManagerService {
  final DatabaseService _db;
  IndexerService? _indexer;

  FileManagerService(this._db);

  void setIndexer(IndexerService indexer) {
    _indexer = indexer;
  }

  Future<List<SharedFolder>> getSharedFolders() async {
    return await _db.getAllSharedFolders();
  }

  /// Finds a shared folder that matches the start of the virtual path.
  /// Returns a record with the SharedFolder and the remaining relative path.
  Future<({SharedFolder folder, String relativePath})?> resolveVirtualPath(
    String path,
  ) async {
    final sanitized = SecurityService.sanitizeRequestPath(path);
    final segments = sanitized.split('/');
    if (segments.isEmpty || segments[0].isEmpty) return null;

    final virtualRoot = segments[0];
    final folders = await getSharedFolders();

    try {
      final folder = folders.firstWhere((f) => f.virtualPath == virtualRoot);
      final relativePath = segments.skip(1).join('/');
      return (folder: folder, relativePath: relativePath);
    } catch (e) {
      return null;
    }
  }

  Future<List<FileSystemEntity>> listDirectory(String physicalPath) async {
    final dir = Directory(physicalPath);
    if (!await dir.exists()) return [];
    return dir.list().toList();
  }

  Future<void> renameEntity(String physicalPath, String newName) async {
    final entity = FileSystemEntity.typeSync(physicalPath);
    final parentDir = p.dirname(physicalPath);
    final newPath = p.join(parentDir, newName);

    if (entity == FileSystemEntityType.file) {
      await File(physicalPath).rename(newPath);
    } else if (entity == FileSystemEntityType.directory) {
      await Directory(physicalPath).rename(newPath);
    }
    _indexer?.indexAll(); // Simple way to keep index in sync
  }

  Future<void> deleteEntity(String physicalPath) async {
    final entity = FileSystemEntity.typeSync(physicalPath);
    if (entity == FileSystemEntityType.file) {
      await File(physicalPath).delete();
    } else if (entity == FileSystemEntityType.directory) {
      await Directory(physicalPath).delete(recursive: true);
    }
    _indexer?.indexAll();
  }

  Future<void> createDirectory(String parentPath, String name) async {
    final newPath = p.join(parentPath, name);
    await Directory(newPath).create();
    _indexer?.indexAll();
  }
}



