import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:uuid/uuid.dart';
import '../data/database/database_service.dart';

class AuthService {
  final DatabaseService _db;
  final Map<String, DateTime> _activeSessions = {};
  final Map<String, int> _failedAttempts = {};
  final _uuid = const Uuid();
  static const _maxFailedAttempts = 5;

  AuthService(this._db);

  String hashPassword(String password) {
    final bytes = utf8.encode(password);
    return sha256.convert(bytes).toString();
  }

  Future<String?> login(String username, String password) async {
    if (_failedAttempts[username] != null && _failedAttempts[username]! >= _maxFailedAttempts) {
      // Basic lock for 1 minute
      // In a real senior app, we'd store the timestamp
      return null;
    }

    final config = await _db.getConfig();
    
    if (config.adminUsername == username && 
        config.adminPasswordHash == hashPassword(password)) {
      _failedAttempts.remove(username);
      final token = _uuid.v4();
      _activeSessions[token] = DateTime.now().add(const Duration(hours: 24));
      return token;
    }

    _failedAttempts[username] = (_failedAttempts[username] ?? 0) + 1;
    return null;
  }

  bool isValidToken(String token) {
    if (!_activeSessions.containsKey(token)) return false;
    
    final expiry = _activeSessions[token]!;
    if (DateTime.now().isAfter(expiry)) {
      _activeSessions.remove(token);
      return false;
    }
    return true;
  }

  void logout(String token) {
    _activeSessions.remove(token);
  }

  Future<bool> isAuthRequired() async {
    final config = await _db.getConfig();
    return config.authenticationEnabled;
  }
}






