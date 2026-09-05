import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miros_share_and_web_dock/features/send/features/discovery/presentation/providers/discovery_provider.dart';
import 'package:miros_share_and_web_dock/features/send/features/settings/presentation/screens/unified_settings_screen.dart';
import 'package:miros_share_and_web_dock/features/send/features/settings/presentation/providers/settings_provider.dart';
import 'package:miros_share_and_web_dock/features/send/features/transfer/presentation/providers/transfer_provider.dart';
import 'package:miros_share_and_web_dock/features/send/features/transfer/domain/entities/transfer_session.dart';
import 'package:miros_share_and_web_dock/features/send/screens/send_selection_screen.dart';
import 'package:miros_share_and_web_dock/features/send/core/theme/app_theme.dart';
import 'package:miros_share_and_web_dock/features/web_dock/features/dashboard/dashboard_screen.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_filex/open_filex.dart';
import 'dart:convert';
import 'dart:io';

class SendHomeScreen extends ConsumerStatefulWidget {
  const SendHomeScreen({super.key});

  @override
  ConsumerState<SendHomeScreen> createState() => _SendHomeScreenState();
}

class _SendHomeScreenState extends ConsumerState<SendHomeScreen> {
  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider);
    final isDesktop = MediaQuery.of(context).size.width > 800;
    final colorScheme = Theme.of(context).colorScheme;

    ref.listen(receiveStateProvider, (previous, next) {
      if (next != null && next.status == TransferStatus.waiting) {
        _showReceiveDialog(context, ref, next);
      }
    });

    return Scaffold(
      body: Row(
        children: [
          if (isDesktop)
            NavigationRail(
              backgroundColor: CyberColors.surfaceStatic,
              selectedIndex: _currentIndex,
              onDestinationSelected: (index) => setState(() => _currentIndex = index),
              labelType: NavigationRailLabelType.all,
              selectedIconTheme: IconThemeData(color: colorScheme.primary),
              unselectedIconTheme: const IconThemeData(color: CyberColors.textSecondaryStatic),
              selectedLabelTextStyle: GoogleFonts.jetBrainsMono(color: colorScheme.primary, fontWeight: FontWeight.bold, fontSize: 10),
              unselectedLabelTextStyle: GoogleFonts.jetBrainsMono(color: CyberColors.textSecondaryStatic, fontSize: 10),
              leading: Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: IconButton(
                  icon: Icon(Icons.tune_outlined, color: colorScheme.primary),
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const UnifiedSettingsScreen())),
                ),
              ),
              destinations: const [
                NavigationRailDestination(icon: Icon(Icons.bolt_outlined), selectedIcon: Icon(Icons.bolt), label: Text('SEND')),
                NavigationRailDestination(icon: Icon(Icons.hub_outlined), selectedIcon: Icon(Icons.hub), label: Text('RECEIVE')),
                NavigationRailDestination(icon: Icon(Icons.lan_outlined), selectedIcon: Icon(Icons.lan), label: Text('WEB DOCK')),
              ],
            ),
          Expanded(
            child: Scaffold(
              appBar: AppBar(
                title: Text('MIROS DOCK', style: GoogleFonts.jetBrainsMono(fontWeight: FontWeight.w900, letterSpacing: 6)),
                centerTitle: true,
                leading: isDesktop
                    ? null
                    : IconButton(
                        icon: Icon(Icons.tune_outlined, color: colorScheme.primary),
                        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const UnifiedSettingsScreen())),
                      ),
                actions: [
                  if (_currentIndex != 2)
                    IconButton(
                      icon: Icon(Icons.refresh, color: colorScheme.primary),
                      onPressed: () => ref.read(deviceListProvider.notifier).scan(),
                    ),
                  const SizedBox(width: 8),
                ],
              ),
              body: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1000),
                  child: IndexedStack(
                    index: _currentIndex,
                    children: [
                      const SendSelectionScreen(),
                      _buildReceiveTab(context, settings),
                      const DashboardScreen(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: isDesktop
          ? null
          : NavigationBar(
              selectedIndex: _currentIndex,
              onDestinationSelected: (index) => setState(() => _currentIndex = index),
              destinations: const [
                NavigationDestination(icon: Icon(Icons.bolt_outlined), selectedIcon: Icon(Icons.bolt), label: 'SEND'),
                NavigationDestination(icon: Icon(Icons.hub_outlined), selectedIcon: Icon(Icons.hub), label: 'RECEIVE'),
                NavigationDestination(icon: Icon(Icons.lan_outlined), selectedIcon: Icon(Icons.lan), label: 'WEB DOCK'),
              ],
            ),
    );
  }

  Widget _buildReceiveTab(BuildContext context, dynamic settings) {
    final colorScheme = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            _buildCyberStatusCard(settings),
            const SizedBox(height: 40),
            FutureBuilder<String?>(
              future: NetworkInfo().getWifiIP(),
              builder: (context, snapshot) {
                final ip = snapshot.data ?? 'DISCONNECTED';
                final qrData = jsonEncode({
                  'name': settings.deviceName,
                  'ip': ip,
                  'port': settings.tcpPort,
                  'type': 'miros_pairing',
                });

                return Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(color: colorScheme.primary.withValues(alpha: 0.2), blurRadius: 40, spreadRadius: 5),
                        ],
                      ),
                      child: QrImageView(data: qrData, version: QrVersions.auto, size: 180.0),
                    ),
                    const SizedBox(height: 32),
                    Text(
                      settings.deviceName.toUpperCase(),
                      style: GoogleFonts.jetBrainsMono(fontSize: 20, fontWeight: FontWeight.w900, letterSpacing: 2, color: colorScheme.primary),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'UPLINK IP: $ip',
                      style: GoogleFonts.jetBrainsMono(color: CyberColors.textSecondaryStatic, fontSize: 10, letterSpacing: 1),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCyberStatusCard(dynamic settings) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: CyberColors.surfaceStatic.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: settings.isVisible ? colorScheme.primary.withValues(alpha: 0.3) : CyberColors.glassStatic),
      ),
      child: SwitchListTile(
        title: Text(
          settings.isVisible ? 'SIGNAL ACTIVE' : 'STEALTH MODE',
          style: GoogleFonts.jetBrainsMono(
            color: settings.isVisible ? colorScheme.primary : CyberColors.textSecondaryStatic,
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
        value: settings.isVisible,
        activeThumbColor: colorScheme.primary,
        onChanged: (value) => ref.read(settingsProvider.notifier).toggleVisibility(value),
      ),
    );
  }

  void _showReceiveDialog(BuildContext context, WidgetRef ref, IncomingTransfer transfer) {
    final colorScheme = Theme.of(context).colorScheme;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: CyberColors.surfaceStatic,
        title: Text('DATA INBOUND', style: GoogleFonts.jetBrainsMono(color: colorScheme.primary, letterSpacing: 2, fontSize: 16)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('FILES: ${transfer.batchMetadata.fileCount}', style: const TextStyle(fontSize: 12)),
            Text('SIZE: ${(transfer.batchMetadata.totalSize / 1024 / 1024).toStringAsFixed(2)} MB', style: const TextStyle(fontSize: 12)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              ref.read(receiveStateProvider.notifier).reject();
              Navigator.pop(context);
            },
            child: const Text('ABORT', style: TextStyle(color: CyberColors.errorStatic)),
          ),
          ElevatedButton(
            onPressed: () {
              ref.read(receiveStateProvider.notifier).accept();
              Navigator.pop(context);
              _showTransferProgressOverlay(context, ref);
            },
            child: const Text('ESTABLISH LINK'),
          ),
        ],
      ),
    );
  }

  void _showTransferProgressOverlay(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      backgroundColor: CyberColors.backgroundStatic,
      enableDrag: false,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (context) => Consumer(
        builder: (context, ref, _) {
          final transfer = ref.watch(receiveStateProvider);
          if (transfer == null) return const SizedBox.shrink();

          final isDone = transfer.status == TransferStatus.completed;
          final isCancelled = transfer.status == TransferStatus.cancelled;

          return Container(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  isDone ? 'SYNC COMPLETE' : (isCancelled ? 'UPLINK ABORTED' : 'BUFFERING STREAM'),
                  style: GoogleFonts.jetBrainsMono(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: isDone ? CyberColors.successStatic : (isCancelled ? CyberColors.errorStatic : colorScheme.primary),
                  ),
                ),
                const SizedBox(height: 24),
                LinearProgressIndicator(
                  value: (isCancelled) ? 0 : transfer.progress,
                  minHeight: 6,
                  backgroundColor: CyberColors.glassStatic,
                  color: isDone ? CyberColors.successStatic : (isCancelled ? CyberColors.errorStatic : colorScheme.primary),
                ),
                const SizedBox(height: 12),
                Text('${(transfer.progress * 100).toStringAsFixed(1)}%', style: const TextStyle(fontSize: 12)),
                
                if (isDone) ...[
                  const SizedBox(height: 24),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('RECEIVED FILES', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: CyberColors.textSecondaryStatic, letterSpacing: 2)),
                  ),
                  const SizedBox(height: 12),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 180),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: transfer.savedPaths.length,
                      itemBuilder: (context, index) {
                        final path = transfer.savedPaths[index];
                        final name = path.split(Platform.pathSeparator).last;
                        return Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: CyberColors.surfaceStatic.withValues(alpha: 0.3),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: CyberColors.glassStatic),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.insert_drive_file_outlined, size: 16, color: CyberColors.textSecondaryStatic),
                              const SizedBox(width: 12),
                              Expanded(child: Text(name, style: const TextStyle(fontSize: 12), overflow: TextOverflow.ellipsis)),
                              TextButton(
                                onPressed: () => OpenFilex.open(path),
                                child: Text('OPEN', style: TextStyle(color: colorScheme.primary, fontSize: 10, fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            if (transfer.savedPaths.isNotEmpty) {
                              OpenFilex.open(File(transfer.savedPaths.first).parent.path);
                            }
                          },
                          icon: const Icon(Icons.folder_open, size: 16),
                          label: const Text('VIEW FOLDER', style: TextStyle(fontSize: 12)),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            ref.read(receiveStateProvider.notifier).dismiss();
                            Navigator.pop(context);
                          },
                          child: const Text('DISCONNECT', style: TextStyle(fontSize: 12)),
                        ),
                      ),
                    ],
                  ),
                ],
                if (!isDone) ...[
                  const SizedBox(height: 24),
                  TextButton(
                    onPressed: () => ref.read(receiveStateProvider.notifier).cancel(),
                    child: const Text('CANCEL UPLINK', style: TextStyle(color: CyberColors.errorStatic, fontSize: 12)),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
