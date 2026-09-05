import 'package:path/path.dart' as p;

class SecurityService {
  /// Validates that [requestedPath] is within [basePath].
  /// Returns the absolute physical path if valid, null otherwise.
  static String? validateAndResolvePath(String basePath, String requestedPath) {
    // 1. Normalize both paths
    final normalizedBase = p.canonicalize(basePath);
    
    // 2. Join and canonicalize the requested path
    // We treat requestedPath as a relative path from basePath
    final resolvedPath = p.canonicalize(p.join(normalizedBase, requestedPath));

    // 3. Verify the resolved path starts with the base path
    // Use p.isWithin to check if resolvedPath is inside normalizedBase
    if (p.isWithin(normalizedBase, resolvedPath) || resolvedPath == normalizedBase) {
      // 4. Double check with File system if it exists (optional but safer)
      // For now, we trust canonicalize/isWithin logic.
      return resolvedPath;
    }

    return null;
  }

  /// Basic sanitization to prevent common traversal patterns before processing.
  static String sanitizeRequestPath(String path) {
    // Decode URL encoding
    String decoded = Uri.decodeComponent(path);
    
    // Normalize separators to forward slash for consistent processing
    decoded = decoded.replaceAll('\\', '/');
    
    // Remove leading/trailing slashes for easier joining
    if (decoded.startsWith('/')) decoded = decoded.substring(1);
    if (decoded.endsWith('/')) decoded = decoded.substring(0, decoded.length - 1);
    
    return decoded;
  }
}






