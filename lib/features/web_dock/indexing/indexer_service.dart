import 'dart:io';
import 'package:logging/logging.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart' as p;
import 'package:isar/isar.dart';
import '../data/database/database_service.dart';
import '../data/models/file_item.dart';

class IndexerService {
  final DatabaseService _db;
  final _logger = Logger('IndexerService');
  bool _isIndexing = false;

  IndexerService(this._db);

  bool get isIndexing => _isIndexing;

  Future<void> indexAll() async {
    if (_isIndexing) return;
    _isIndexing = true;
    _logger.info('Syncing library index...');

    try {
      final folders = await _db.getAllSharedFolders();
      
      // We perform a sync: 
      // 1. Mark all items as potentially stale (or just compare paths)
      // 2. Scan and upsert
      // 3. Remove items whose physical path no longer exists (Optional: can be slow on large drives)

      for (var folder in folders) {
        await _indexDirectory(Directory(folder.physicalPath), folder.virtualPath, folder.id);
      }
      
      // Cleanup: remove entries where physical file no longer exists
      // In a real senior app, we'd batch this.
      await _cleanupStaleEntries();

      _logger.info('Index synchronization complete.');
    } catch (e) {
      _logger.severe('Indexing error: $e');
    } finally {
      _isIndexing = false;
    }
  }

  Future<void> _indexDirectory(Directory dir, String currentVirtualPath, int sharedFolderId) async {
    if (!await dir.exists()) return;

    try {
      final entities = await dir.list().toList();
      final List<FileItem> batch = [];

      for (var entity in entities) {
        final stat = entity.statSync();
        final name = p.basename(entity.path);
        final virtualPath = p.join(currentVirtualPath, name).replaceAll('\\', '/');

        final item = FileItem()
          ..name = name
          ..physicalPath = entity.path
          ..virtualPath = virtualPath
          ..size = stat.size
          ..modifiedAt = stat.modified
          ..isDirectory = entity is Directory
          ..parentId = sharedFolderId;

        if (entity is File) {
          final mime = lookupMimeType(entity.path);
          item.mimeType = mime;
          item.fileType = _getFileType(entity.path, mime);
        } else {
          item.fileType = 'directory';
        }

        batch.add(item);

        if (entity is Directory) {
          await _indexDirectory(entity, virtualPath, sharedFolderId);
        }
      }

      if (batch.isNotEmpty) {
        await _db.isar.writeTxn(() async {
          // PutAll uses physicalPath as a unique key if we had one, 
          // but Isar needs manual check or @Index(unique: true)
          // For now we just put them all.
          await _db.isar.fileItems.putAll(batch);
        });
      }
    } catch (e) {
      _logger.warning('Skipping directory ${dir.path} due to error: $e');
    }
  }

  Future<void> _cleanupStaleEntries() async {
    final allItems = await _db.isar.fileItems.where().findAll();
    final List<int> idsToDelete = [];
    
    for (var item in allItems) {
      if (item.isDirectory) {
        if (!await Directory(item.physicalPath).exists()) idsToDelete.add(item.id);
      } else {
        if (!await File(item.physicalPath).exists()) idsToDelete.add(item.id);
      }
    }

    if (idsToDelete.isNotEmpty) {
      await _db.isar.writeTxn(() async {
        await _db.isar.fileItems.deleteAll(idsToDelete);
      });
    }
  }

  String _getFileType(String path, String? mime) {
    final ext = p.extension(path).toLowerCase();
    if (mime?.startsWith('video/') == true || ['.mkv', '.avi', '.mp4', '.webm'].contains(ext)) return 'video';
    if (mime?.startsWith('audio/') == true || ['.mp3', '.wav', '.m4a', '.ogg'].contains(ext)) return 'audio';
    if (mime?.startsWith('image/') == true || ['.jpg', '.jpeg', '.png', '.gif', '.webp'].contains(ext)) return 'image';
    if (ext == '.pdf' || mime == 'application/pdf') return 'document';
    if (['.zip', '.rar', '.7z', '.tar', '.gz'].contains(ext)) return 'archive';
    return 'other';
  }

  Future<List<FileItem>> search(String query, {String? type}) async {
    final allItems = await _db.isar.fileItems.where().findAll();
    
    return allItems.where((item) {
      final matchesQuery = query.isEmpty || 
          item.name.toLowerCase().contains(query.toLowerCase());
      
      final matchesType = type == null || type == 'all' || 
          item.fileType == type;
      
      return matchesQuery && matchesType;
    }).toList();
  }
}






