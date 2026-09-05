import 'dart:async';
import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_cors_headers/shelf_cors_headers.dart';
import 'package:logging/logging.dart';
import 'file_manager_service.dart';
import 'auth_service.dart';
import '../indexing/indexer_service.dart';
import '../data/database/database_service.dart';
import 'handlers/file_handler.dart';
import 'handlers/asset_handler.dart';
import 'handlers/auth_handler.dart';
import 'handlers/auth_middleware.dart';

enum ServerStatus { stopped, starting, running, stopping, error }

class HttpServerService {
  final _logger = Logger('HttpServerService');
  final FileManagerService _fileManager;
  final AuthService _auth;
  final DatabaseService _db;
  final IndexerService _indexer;
  
  HttpServer? _server;
  ServerStatus _status = ServerStatus.stopped;
  String? _error;

  HttpServerService(this._fileManager, this._auth, this._db, this._indexer);

  ServerStatus get status => _status;
  String? get error => _error;
  int? get port => _server?.port;
  String? get address => _server?.address.address;

  final _statusController = StreamController<ServerStatus>.broadcast();
  Stream<ServerStatus> get statusStream => _statusController.stream;

  Future<void> start(String ip, int port) async {
    if (_status == ServerStatus.running || _status == ServerStatus.starting) return;

    _status = ServerStatus.starting;
    _statusController.add(_status);
    _error = null;

    try {
      final router = Router();
      final fileHandler = FileHandler(_fileManager, _db, _indexer);
      final assetHandler = AssetHandler('assets/web_server');
      final authHandler = AuthHandler(_auth);

      // 1. PUBLIC API ROUTES
      router.mount('/api/auth/', authHandler.handler);
      router.get('/api/status', (Request request) {
        return Response.ok('{"status": "online"}', headers: {'content-type': 'application/json'});
      });

      // 2. PROTECTED ROUTES
      final protectedPipeline = const Pipeline().addMiddleware(authMiddleware(_auth));

      router.mount('/api/folders', protectedPipeline.addHandler(fileHandler.foldersHandler));
      router.mount('/api/files/', protectedPipeline.addHandler(fileHandler.filesHandler));
      router.mount('/api/search', protectedPipeline.addHandler(fileHandler.searchHandler));
      router.mount('/api/upload/', protectedPipeline.addHandler(fileHandler.uploadHandler));
      router.mount('/files/', protectedPipeline.addHandler(fileHandler.rawHandler));

      // 3. CORE PIPELINE
      final handler = const Pipeline()
          .addMiddleware(corsHeaders())
          .addMiddleware(logRequests(logger: (msg, isError) {
            if (isError) {
              _logger.severe(msg);
            } else {
              _logger.info(msg);
            }
          }))
          .addHandler((Request request) async {
            final response = await router(request);
            if (response.statusCode != 404) return response;
            return assetHandler.handle(request);
          });

      _server = await io.serve(handler, ip, port);
      _status = ServerStatus.running;
      _logger.info('Server started on http://${_server!.address.address}:${_server!.port}');
    } catch (e) {
      _status = ServerStatus.error;
      _error = e.toString();
      _logger.severe('Failed to start server: $e');
    } finally {
      _statusController.add(_status);
    }
  }

  Future<void> stop() async {
    if (_status == ServerStatus.stopped || _status == ServerStatus.stopping) return;

    _status = ServerStatus.stopping;
    _statusController.add(_status);

    try {
      await _server?.close(force: true);
      _server = null;
      _status = ServerStatus.stopped;
      _logger.info('Server stopped');
    } catch (e) {
      _status = ServerStatus.error;
      _error = e.toString();
      _logger.severe('Error stopping server: $e');
    } finally {
      _statusController.add(_status);
    }
  }

  void dispose() {
    _statusController.close();
  }
}






