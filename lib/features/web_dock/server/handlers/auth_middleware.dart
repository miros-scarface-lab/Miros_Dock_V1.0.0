import 'package:shelf/shelf.dart';
import '../auth_service.dart';

Middleware authMiddleware(AuthService authService) {
  return (Handler innerHandler) {
    return (Request request) async {
      // 1. Check if auth is required
      if (!await authService.isAuthRequired()) {
        return innerHandler(request);
      }

      // 2. Allow login endpoint and assets without auth (so login page can load)
      var path = request.url.path;
      if (!path.startsWith('/')) path = '/$path';

      if (path == '/api/auth/login' || 
          path == '/login.html' || 
          path.startsWith('/css/') || 
          path.startsWith('/js/')) {
        return innerHandler(request);
      }

      // 3. Check for token in headers or cookies
      String? token;
      
      // Check Authorization header
      final authHeader = request.headers['Authorization'];
      if (authHeader != null && authHeader.startsWith('Bearer ')) {
        token = authHeader.substring(7);
      }

      // If no token in header, check cookies (for simple browser downloads/streaming)
      if (token == null) {
        final cookieHeader = request.headers['cookie'];
        if (cookieHeader != null) {
          final cookies = cookieHeader.split(';').map((c) => c.trim());
          for (var cookie in cookies) {
            if (cookie.startsWith('session_token=')) {
              token = cookie.substring(14);
              break;
            }
          }
        }
      }

      if (token != null && authService.isValidToken(token)) {
        return innerHandler(request);
      }

      // 4. Return 401 Unauthorized
      return Response.unauthorized('Authentication required');
    };
  };
}






