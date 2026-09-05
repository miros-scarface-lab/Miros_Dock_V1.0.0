import 'dart:io';
import 'package:shelf/shelf.dart';

class Range {
  final int start;
  final int end;

  Range(this.start, this.end);

  int get length => end - start + 1;
}

class RangeHandler {
  /// Parses the Range header. Format: "bytes=start-end"
  /// Returns null if header is missing or invalid.
  static Range? parseRangeHeader(String? header, int fileSize) {
    if (header == null || !header.startsWith('bytes=')) return null;

    try {
      final rangeStr = header.substring(6);
      final parts = rangeStr.split('-');
      if (parts.length != 2) return null;

      int start;
      int end;

      if (parts[0].isEmpty) {
        // -500 (last 500 bytes)
        end = fileSize - 1;
        start = fileSize - int.parse(parts[1]);
      } else if (parts[1].isEmpty) {
        // 500- (from 500 to end)
        start = int.parse(parts[0]);
        end = fileSize - 1;
      } else {
        // 500-1000
        start = int.parse(parts[0]);
        end = int.parse(parts[1]);
      }

      if (start < 0 || end >= fileSize || start > end) return null;

      return Range(start, end);
    } catch (e) {
      return null;
    }
  }

  /// Creates a 206 Partial Content response for the given file and range.
  static Response createRangeResponse(File file, Range range, String mimeType) {
    final stream = file.openRead(range.start, range.end + 1);
    final fileSize = file.lengthSync();

    return Response(
      206,
      body: stream,
      headers: {
        'Content-Type': mimeType,
        'Accept-Ranges': 'bytes',
        'Content-Range': 'bytes ${range.start}-${range.end}/$fileSize',
        'Content-Length': range.length.toString(),
        'Content-Disposition': 'inline; filename="${Uri.encodeComponent(file.path.split(Platform.pathSeparator).last)}"',
      },
    );
  }
}






