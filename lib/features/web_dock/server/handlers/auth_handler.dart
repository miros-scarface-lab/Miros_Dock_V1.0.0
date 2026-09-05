import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../auth_service.dart';

class AuthHandler {
  final AuthService _authService;

  AuthHandler(this._authService);

  Handler get handler {
    final router = Router();

    router.post('/login', (Request request) async {
      try {
        final body = await request.readAsString();
        final data = jsonDecode(body);
        final username = data['username'] as String?;
        final password = data['password'] as String?;

        if (username == null || password == null) {
          return Response.badRequest(body: 'Username and password required');
        }

        final token = await _authService.login(username, password);
        if (token != null) {
          return Response.ok(
            jsonEncode({'token': token}),
            headers: {
              'content-type': 'application/json',
              'Set-Cookie': 'session_token=$token; Path=/; HttpOnly; SameSite=Strict',
            },
          );
        } else {
          return Response.forbidden('Invalid credentials');
        }
      } catch (e) {
        return Response.badRequest(body: 'Invalid request body');
      }
    });

    router.post('/logout', (Request request) {
      final authHeader = request.headers['Authorization'];
      if (authHeader != null && authHeader.startsWith('Bearer ')) {
        final token = authHeader.substring(7);
        _authService.logout(token);
      }
      return Response.ok('Logged out', headers: {
        'Set-Cookie': 'session_token=; Path=/; Expires=Thu, 01 Jan 1970 00:00:00 GMT',
      });
    });

    return router.call;
  }
}






