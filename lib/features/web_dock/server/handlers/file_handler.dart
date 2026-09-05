import 'dart:convert';
import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:path/path.dart' as p;
import 'package:mime/mime.dart';
import '../file_manager_service.dart';
import '../security_service.dart';
import '../range_handler.dart';
import '../upload_service.dart';
import '../../data/database/database_service.dart';
import '../../indexing/indexer_service.dart';

class FileHandler {
  final FileManagerService _fileManager;
  final DatabaseService _db;
  final IndexerService _indexer;
  final _uploadService = UploadService();

  FileHandler(this._fileManager, this._db, this._indexer);

  /// Handler for listing top-level shared folders.
  Handler get foldersHandler {
    final router = Router();
    router.get('/', (Request request) async {
      final folders = await _fileManager.getSharedFolders();
      final data = folders
          .map(
            (f) => {'id': f.id, 'name': f.name, 'virtualPath': f.virtualPath},
          )
          .toList();
      return Response.ok(
        jsonEncode(data),
        headers: {
          'content-type': 'application/json',
          'Cache-Control': 'no-store',
        },
      );
    });
    return router.call;
  }

  /// Handler for searching indexed files.
  Handler get searchHandler {
    final router = Router();
    router.get('/', (Request request) async {
      final query = request.url.queryParameters['q'] ?? '';
      final type = request.url.queryParameters['type'];

      if (query.isEmpty && type == null) {
        return Response.badRequest(
          body: 'Query parameter "q" or "type" is required',
        );
      }

      final results = await _indexer.search(query, type: type);
      final data = results
          .map(
            (item) => {
              'name': item.name,
              'virtualPath': item.virtualPath,
              'isDirectory': item.isDirectory,
              'size': item.size,
              'fileType': item.fileType,
            },
          )
          .toList();

      return Response.ok(
        jsonEncode(data),
        headers: {'content-type': 'application/json'},
      );
    });
    return router.call;
  }

  /// Handler for file operations (Metadata, Rename, Delete, Create Folder).
  Handler get filesHandler {
    final router = Router();

    // List directory content or get file info (JSON)
    router.get('/<path|.*>', (Request request, String path) async {
      final resolved = await _fileManager.resolveVirtualPath(path);
      if (resolved == null) return Response.notFound('Folder not found');

      final physicalPath = SecurityService.validateAndResolvePath(
        resolved.folder.physicalPath,
        resolved.relativePath,
      );
      if (physicalPath == null) return Response.forbidden('Access denied');

      final entity = FileSystemEntity.typeSync(physicalPath);
      if (entity == FileSystemEntityType.notFound) {
        return Response.notFound('File not found');
      }

      if (entity == FileSystemEntityType.directory) {
        final dir = Directory(physicalPath);
        final list = await dir.list().toList();
        final data = list.map((e) {
          final stat = e.statSync();
          return {
            'name': p.basename(e.path),
            'isDirectory': e is Directory,
            'size': stat.size,
            'modified': stat.modified.toIso8601String(),
          };
        }).toList();
        return Response.ok(
          jsonEncode(data),
          headers: {'content-type': 'application/json'},
        );
      } else {
        final file = File(physicalPath);
        final stat = file.statSync();
        return Response.ok(
          jsonEncode({
            'name': p.basename(physicalPath),
            'isDirectory': false,
            'size': stat.size,
            'modified': stat.modified.toIso8601String(),
            'mimeType': lookupMimeType(physicalPath),
          }),
          headers: {'content-type': 'application/json'},
        );
      }
    });

    // Create Folder
    router.post('/<path|.*>', (Request request, String path) async {
      final config = await _db.getConfig();
      if (!config.uploadEnabled) return Response.forbidden('Uploads disabled');

      final resolved = await _fileManager.resolveVirtualPath(path);
      if (resolved == null) return Response.notFound('Not found');

      final physicalPath = SecurityService.validateAndResolvePath(
        resolved.folder.physicalPath,
        resolved.relativePath,
      );
      if (physicalPath == null) return Response.forbidden('Forbidden');

      final body = await request.readAsString();
      final data = jsonDecode(body);
      final name = data['name'] as String?;
      if (name == null) return Response.badRequest(body: 'Name required');

      await _fileManager.createDirectory(physicalPath, name);
      return Response.ok('Folder created');
    });

    // Rename
    router.patch('/<path|.*>', (Request request, String path) async {
      final config = await _db.getConfig();
      if (!config.renameEnabled) return Response.forbidden('Rename disabled');

      final resolved = await _fileManager.resolveVirtualPath(path);
      if (resolved == null) return Response.notFound('Not found');

      final physicalPath = SecurityService.validateAndResolvePath(
        resolved.folder.physicalPath,
        resolved.relativePath,
      );
      if (physicalPath == null) return Response.forbidden('Forbidden');

      final body = await request.readAsString();
      final data = jsonDecode(body);
      final newName = data['name'] as String?;
      if (newName == null) {
        return Response.badRequest(body: 'New name required');
      }

      await _fileManager.renameEntity(physicalPath, newName);
      return Response.ok('Renamed');
    });

    // Delete
    router.delete('/<path|.*>', (Request request, String path) async {
      final config = await _db.getConfig();
      if (!config.deleteEnabled) return Response.forbidden('Delete disabled');

      final resolved = await _fileManager.resolveVirtualPath(path);
      if (resolved == null) return Response.notFound('Not found');

      final physicalPath = SecurityService.validateAndResolvePath(
        resolved.folder.physicalPath,
        resolved.relativePath,
      );
      if (physicalPath == null) return Response.forbidden('Forbidden');

      await _fileManager.deleteEntity(physicalPath);
      return Response.ok('Deleted');
    });

    return router.call;
  }

  /// Handler for raw file streaming (bytes).
  Handler get rawHandler {
    final router = Router();
    router.get('/<path|.*>', (Request request, String path) async {
      final config = await _db.getConfig();
      if (!config.downloadEnabled) {
        return Response.forbidden('Downloads disabled');
      }

      final resolved = await _fileManager.resolveVirtualPath(path);
      if (resolved == null) return Response.notFound('Not found');

      var physicalPath = SecurityService.validateAndResolvePath(
        resolved.folder.physicalPath,
        resolved.relativePath,
      );
      if (physicalPath == null) return Response.forbidden('Forbidden');

      final entity = FileSystemEntity.typeSync(physicalPath);
      if (entity == FileSystemEntityType.notFound) {
        return Response.notFound('File not found');
      }

      // If it's a directory, look for index.html
      if (entity == FileSystemEntityType.directory) {
        // Redirect to add trailing slash if missing (important for relative asset links in HTML)
        if (!request.requestedUri.path.endsWith('/')) {
          return Response.movedPermanently('${request.requestedUri.path}/');
        }

        physicalPath = p.join(physicalPath, 'index.html');
        if (!File(physicalPath).existsSync()) {
          return Response.notFound('Index file not found in directory');
        }
      }

      final file = File(physicalPath);
      if (!await file.exists()) return Response.notFound('File not found');

      var mimeType = lookupMimeType(physicalPath) ?? 'application/octet-stream';
      if (mimeType == 'text/html') mimeType += '; charset=utf-8';

      final rangeHeader = request.headers['range'];
      final downloadParam = request.url.queryParameters['download'];
      final isDownload = downloadParam == '1';
      final fileSize = file.lengthSync();
      final filename = p.basename(physicalPath);
      final encodedFilename = Uri.encodeComponent(filename);

      if (rangeHeader != null) {
        final range = RangeHandler.parseRangeHeader(rangeHeader, fileSize);
        if (range != null) {
          return RangeHandler.createRangeResponse(file, range, mimeType);
        } else {
          return Response(416, headers: {'Content-Range': 'bytes */$fileSize'});
        }
      }

      return Response.ok(
        file.openRead(),
        headers: {
          'content-type': mimeType,
          'content-length': fileSize.toString(),
          'accept-ranges': 'bytes',
          'content-disposition': isDownload 
            ? 'attachment; filename="$encodedFilename"; filename*=UTF-8\'\'$encodedFilename'
            : 'inline; filename="$encodedFilename"; filename*=UTF-8\'\'$encodedFilename',
        },
      );
    });
    return router.call;
  }

  /// Handler for uploads.
  Handler get uploadHandler {
    final router = Router();
    router.post('/<path|.*>', (Request request, String path) async {
      final config = await _db.getConfig();
      if (!config.uploadEnabled) return Response.forbidden('Uploads disabled');

      final resolved = await _fileManager.resolveVirtualPath(path);
      if (resolved == null) return Response.notFound('Not found');

      final physicalPath = SecurityService.validateAndResolvePath(
        resolved.folder.physicalPath,
        resolved.relativePath,
      );
      if (physicalPath == null) return Response.forbidden('Forbidden');

      return await _uploadService.handleUpload(request, physicalPath);
    });
    return router.call;
  }
}



