import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:miros_share_and_web_dock/core/app_providers.dart';
import '../../server/http_server_service.dart';
import '../../network/network_service.dart';
import '../../server/file_manager_service.dart';
import '../../server/auth_service.dart';
import '../../indexing/indexer_service.dart';
import '../../core/utils/foreground_service.dart';
import '../settings/shared_folders_screen.dart';
import '../settings/server_settings_screen.dart';

final indexerServiceProvider = Provider((ref) {
  final db = ref.watch(databaseProvider);
  return IndexerService(db);
});

final authServiceProvider = Provider((ref) {
  final db = ref.watch(databaseProvider);
  return AuthService(db);
});

final httpServerProvider = Provider((ref) {
  final fileManager = ref.watch(fileManagerProvider);
  final auth = ref.watch(authServiceProvider);
  final db = ref.watch(databaseProvider);
  final indexer = ref.watch(indexerServiceProvider);

  fileManager.setIndexer(indexer);

  return HttpServerService(fileManager, auth, db, indexer);
});

final networkServiceProvider = Provider((ref) => NetworkService());

final serverStatusProvider = StreamProvider((ref) {
  final server = ref.watch(httpServerProvider);
  return server.statusStream;
});

final interfacesProvider = FutureProvider((ref) async {
  final network = ref.watch(networkServiceProvider);
  return network.getAvailableInterfaces();
});

final fileManagerProvider = Provider((ref) {
  final db = ref.watch(databaseProvider);
  final manager = FileManagerService(db);
  return manager;
});

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  late final StreamSubscription<ConnectivityResult> _connectivitySubscription;
  String? _selectedManualUrl;

  @override
  void initState() {
    super.initState();
    _connectivitySubscription = ref
        .read(networkServiceProvider)
        .onConnectivityChanged
        .listen((_) {
          ref.invalidate(interfacesProvider);
        });
    _requestPermissions();
  }

  Future<void> _requestPermissions() async {
    if (Platform.isAndroid) {
      await [Permission.storage, Permission.manageExternalStorage].request();
    }
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  List<String> _getAllServerUrls(HttpServerService server) {
    if (server.address != '0.0.0.0') {
      return ['http://${server.address}:${server.port}'];
    }

    final interfaces = ref.read(interfacesProvider).asData?.value ?? [];
    return interfaces
        .where((i) => i.ip != '0.0.0.0' && !i.ip.startsWith('127.'))
        .map((i) => 'http://${i.ip}:${server.port}')
        .toList();
  }

  String _getPrimaryUrl(HttpServerService server) {
    final allUrls = _getAllServerUrls(server);
    if (_selectedManualUrl != null && allUrls.contains(_selectedManualUrl)) {
      return _selectedManualUrl!;
    }

    if (allUrls.isEmpty) return 'http://localhost:${server.port}';

    final interfaces = ref.read(interfacesProvider).asData?.value ?? [];
    try {
      final wifi = interfaces.firstWhere(
        (i) => i.type == NetworkType.wifi && i.ip != '0.0.0.0',
      );
      return 'http://${wifi.ip}:${server.port}';
    } catch (_) {
      return allUrls.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    final serverStatus =
        ref.watch(serverStatusProvider).value ?? ServerStatus.stopped;
    final server = ref.watch(httpServerProvider);
    final indexer = ref.watch(indexerServiceProvider);
    final allUrls = _getAllServerUrls(server);
    final primaryUrl = _getPrimaryUrl(server);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          'MIROS WEB DOCK',
          style: GoogleFonts.jetBrainsMono(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: false,
        actions: [
          _IndexingAction(indexer: indexer),
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ServerSettingsScreen()),
            ),
            tooltip: 'Settings',
          ),
          IconButton(
            icon: const Icon(Icons.folder_open_outlined),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SharedFoldersScreen()),
            ),
            tooltip: 'Shared Folders',
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          _StatusCard(
            server: server,
            status: serverStatus,
            url: primaryUrl,
            allUrls: allUrls,
            onUrlSelected: (url) => setState(() => _selectedManualUrl = url),
          ),
          if (serverStatus == ServerStatus.running) ...[
            const SizedBox(height: 20),
            _QrCard(url: primaryUrl),
          ],
          const SizedBox(height: 40),
          _MainActionButton(server: server, status: serverStatus),
          if (server.error != null) ...[
            const SizedBox(height: 16),
            Center(
              child: Text(
                'Error: ${server.error}',
                style: const TextStyle(color: Colors.red),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _IndexingAction extends StatefulWidget {
  final IndexerService indexer;
  const _IndexingAction({required this.indexer});

  @override
  State<_IndexingAction> createState() => _IndexingActionState();
}

class _IndexingActionState extends State<_IndexingAction>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    if (widget.indexer.isIndexing) _controller.repeat();
  }

  @override
  void didUpdateWidget(covariant _IndexingAction oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.indexer.isIndexing) {
      _controller.repeat();
    } else {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: IconButton(
        icon: const Icon(Icons.sync),
        onPressed: widget.indexer.isIndexing
            ? null
            : () => widget.indexer.indexAll().then((_) => setState(() {})),
        tooltip: 'Refresh Library',
      ),
    );
  }
}

class _StatusCard extends StatelessWidget {
  final HttpServerService server;
  final ServerStatus status;
  final String url;
  final List<String> allUrls;
  final Function(String) onUrlSelected;

  const _StatusCard({
    required this.server,
    required this.status,
    required this.url,
    required this.allUrls,
    required this.onUrlSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey[200]!),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Server Instance',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
                _StatusBadge(status: status),
              ],
            ),
            if (status == ServerStatus.running) ...[
              const SizedBox(height: 24),
              SelectableText(
                url,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 8),
              if (allUrls.length > 1) ...[
                const Text(
                  'Other active connections:',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: allUrls
                      .where((u) => u != url)
                      .map(
                        (u) => ActionChip(
                          label: Text(
                            u.replaceAll('http://', '').split(':').first,
                            style: const TextStyle(fontSize: 11),
                          ),
                          onPressed: () => onUrlSelected(u),
                          padding: EdgeInsets.zero,
                          visualDensity: VisualDensity.compact,
                        ),
                      )
                      .toList(),
                ),
              ],
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.lan, size: 16, color: Colors.grey),
                  const SizedBox(width: 8),
                  Text(
                    'Port ${server.port}',
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(width: 16),
                  IconButton(
                    icon: const Icon(Icons.copy_rounded, size: 20),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: url));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('URL copied')),
                      );
                    },
                  ),
                ],
              ),
            ] else ...[
              const SizedBox(height: 24),
              const Text(
                'Ready to Start',
                style: TextStyle(fontSize: 20, color: Colors.grey),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _QrCard extends StatelessWidget {
  final String url;
  const _QrCard({required this.url});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey[200]!),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text(
              'Connect Other Devices',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            QrImageView(data: url, version: QrVersions.auto, size: 160.0),
            const SizedBox(height: 12),
            const Text(
              'Scan to open in browser',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

class _MainActionButton extends ConsumerWidget {
  final HttpServerService server;
  final ServerStatus status;

  const _MainActionButton({required this.server, required this.status});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isRunning = status == ServerStatus.running;
    return Center(
      child: SizedBox(
        width: 240,
        height: 64,
        child: ElevatedButton(
          onPressed: () async {
            if (!isRunning) {
              final config = await ref.read(databaseProvider).getConfig();
              // Always use 0.0.0.0 for maximum simplicity
              await server.start('0.0.0.0', config.port);
              await ForegroundService.start(
                'Server running on port ${config.port}',
              );
            } else {
              await server.stop();
              await ForegroundService.stop();
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: isRunning ? Colors.red[50] : Colors.blue,
            foregroundColor: isRunning ? Colors.red : Colors.white,
            elevation: isRunning ? 0 : 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32),
            ),
          ),
          child: Text(
            isRunning ? 'STOP SERVER' : 'START SERVER',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final ServerStatus status;
  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    Color color;
    String label;

    switch (status) {
      case ServerStatus.stopped:
        color = Colors.grey;
        label = 'OFFLINE';
        break;
      case ServerStatus.starting:
        color = Colors.orange;
        label = 'STARTING';
        break;
      case ServerStatus.running:
        color = Colors.green;
        label = 'ONLINE';
        break;
      case ServerStatus.stopping:
        color = Colors.orange;
        label = 'STOPPING';
        break;
      case ServerStatus.error:
        color = Colors.red;
        label = 'ERROR';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}



