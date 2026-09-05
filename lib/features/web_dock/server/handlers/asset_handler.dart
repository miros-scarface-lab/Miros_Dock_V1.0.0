import 'package:flutter/services.dart';
import 'package:shelf/shelf.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart' as p;
import 'package:logging/logging.dart';

class AssetHandler {
  final String assetPath;
  final _logger = Logger('AssetHandler');

  AssetHandler(this.assetPath);

  Future<Response> handle(Request request) async {
    String path = request.url.path;
    
    // 1. Normalize path: remove leading slashes and handle empty/root
    if (path.startsWith('/')) path = path.substring(1);
    if (path.isEmpty || path == '/') {
      path = 'index.html';
    }

    // 2. Build full asset path
    final fullPath = p.join(assetPath, path).replaceAll('\\', '/');
    _logger.fine('Serving asset: $fullPath');
    
    try {
      final byteData = await rootBundle.load(fullPath);
      final bytes = byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);
      
      var mimeType = lookupMimeType(fullPath) ?? 'application/octet-stream';
      if (mimeType.startsWith('text/')) {
        mimeType += '; charset=utf-8';
      }
      
      return Response.ok(
        bytes,
        headers: {
          'Content-Type': mimeType,
          'Content-Length': bytes.length.toString(),
          'Cache-Control': 'no-cache, no-store, must-revalidate', // Force refresh during dev
          'Pragma': 'no-cache',
          'Expires': '0',
        },
      );
    } catch (e) {
      _logger.warning('Asset not found: $fullPath');
      
      // If asset not found and it's a directory-like path, try returning index.html for SPA support
      if (!path.contains('.')) {
        try {
          final byteData = await rootBundle.load(p.join(assetPath, 'index.html').replaceAll('\\', '/'));
          final bytes = byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);
          return Response.ok(bytes, headers: {'Content-Type': 'text/html; charset=utf-8', 'Cache-Control': 'no-cache'});
        } catch (_) {}
      }
      
      return Response.notFound('Asset not found: $path');
    }
  }
}






