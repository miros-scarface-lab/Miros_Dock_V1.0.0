import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf_multipart/shelf_multipart.dart';
import 'package:path/path.dart' as p;
import 'package:logging/logging.dart';

class UploadService {
  final _logger = Logger('UploadService');

  Future<Response> handleUpload(Request request, String targetDirectory) async {
    final multipart = request.multipart();
    if (multipart == null) {
      return Response.badRequest(body: 'Not a multipart request');
    }

    try {
      await for (final part in multipart.parts) {
        final contentDisposition = part.headers['content-disposition'];
        if (contentDisposition == null) continue;

        // Simple parsing of filename from Content-Disposition
        final match = RegExp(r'filename="([^"]+)"').firstMatch(contentDisposition);
        if (match == null) continue;

        String filename = match.group(1)!;

        // Support for folder upload via relative path in part headers (webkitRelativePath)
        // or a custom header if sent by the client.
        final relativePath = part.headers['x-relative-path'] ?? '';
        
        // Basic filename/path sanitization
        filename = filename.replaceAll(RegExp(r'[\\/:*?"<>|]'), '_');
        
        String targetPath = targetDirectory;
        if (relativePath.isNotEmpty) {
          // Normalize and ensure path is safe
          final safeRelativePath = relativePath
              .replaceAll('\\', '/')
              .split('/')
              .where((s) => s.isNotEmpty && s != '..')
              .join(Platform.pathSeparator);
          
          if (safeRelativePath.isNotEmpty) {
            targetPath = p.join(targetDirectory, p.dirname(safeRelativePath));
            await Directory(targetPath).create(recursive: true);
          }
        }
        
        final physicalPath = p.join(targetPath, filename);
        
        _logger.info('Uploading file to: $physicalPath');
        
        final file = File(physicalPath);
        final sink = file.openWrite();
        
        try {
          await sink.addStream(part);
        } finally {
          await sink.close();
        }
      }

      return Response.ok('Upload complete');
    } catch (e) {
      _logger.severe('Upload failed: $e');
      return Response.internalServerError(body: 'Upload failed: $e');
    }
  }
}






