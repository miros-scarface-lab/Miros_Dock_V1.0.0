import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miros_share_and_web_dock/features/send/core/config/app_config.dart';
import 'package:miros_share_and_web_dock/features/send/core/theme/app_theme.dart';
import 'package:miros_share_and_web_dock/features/send/features/discovery/domain/entities/device.dart';
import 'package:miros_share_and_web_dock/features/send/features/discovery/presentation/providers/discovery_provider.dart';
import 'package:miros_share_and_web_dock/features/send/screens/qr_scanner_screen.dart';
import 'package:miros_share_and_web_dock/features/send/features/transfer/presentation/screens/transfer_screen.dart';

class SendSelectionScreen extends ConsumerStatefulWidget {
  const SendSelectionScreen({super.key});

  @override
  ConsumerState<SendSelectionScreen> createState() =>
      _SendSelectionScreenState();
}

class _SendSelectionScreenState extends ConsumerState<SendSelectionScreen> {
  @override
  Widget build(BuildContext context) {
    final devices = ref.watch(deviceListProvider);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 24),
          _buildCategoryGrid(context, colorScheme),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                const Text(
                  'NEARBY NODES',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 14,
                    letterSpacing: 2,
                    color: CyberColors.textSecondaryStatic,
                  ),
                ),
                const Spacer(),
                TextButton.icon(
                  onPressed: () => _handleManualIp(context),
                  icon: const Icon(Icons.lan_outlined, size: 16),
                  label: const Text(
                    'MANUAL IP',
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                  style: TextButton.styleFrom(
                    foregroundColor: colorScheme.primary,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.qr_code_scanner,
                    color: colorScheme.primary,
                  ),
                  onPressed: () => _handleQrScan(context),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: devices.isEmpty
                ? _buildEmptyState()
                : _buildDeviceList(context, devices, colorScheme),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryGrid(BuildContext context, ColorScheme colors) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: CyberColors.surfaceStatic,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: CyberColors.glassStatic),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: _buildCategoryItem(
                    context,
                    Icons.image,
                    'IMAGES',
                    FileType.image,
                    colors,
                  ),
                ),
                Expanded(
                  child: _buildCategoryItem(
                    context,
                    Icons.video_library,
                    'VIDEOS',
                    FileType.video,
                    colors,
                  ),
                ),
                Expanded(
                  child: _buildCategoryItem(
                    context,
                    Icons.picture_as_pdf,
                    'DOCS',
                    FileType.custom,
                    colors,
                    allowedExtensions: ['pdf'],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildCategoryItem(
                    context,
                    Icons.insert_drive_file,
                    'FILES',
                    FileType.any,
                    colors,
                  ),
                ),
                Expanded(
                  child: _buildCategoryItem(
                    context,
                    Icons.folder_open,
                    'FOLDERS',
                    FileType.any,
                    colors,
                    isFolder: true,
                  ),
                ),
                const Expanded(child: SizedBox.shrink()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryItem(
    BuildContext context,
    IconData icon,
    String label,
    FileType type,
    ColorScheme colors, {
    List<String>? allowedExtensions,
    bool isFolder = false,
  }) {
    return InkWell(
      onTap: () =>
          _handleCategorySelection(context, type, allowedExtensions, isFolder),
      borderRadius: BorderRadius.circular(12),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: CyberColors.backgroundStatic,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: colors.primary.withValues(alpha: 0.3),
              ),
            ),
            child: Icon(icon, size: 24, color: colors.primary),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleCategorySelection(
    BuildContext context,
    FileType type,
    List<String>? allowedExtensions,
    bool isFolder,
  ) async {
    List<File> files = [];

    if (isFolder) {
      String? directoryPath = await FilePicker.getDirectoryPath();
      if (directoryPath != null) {
        final dir = Directory(directoryPath);
        files = dir.listSync().whereType<File>().toList();
      }
    } else {
      final result = await FilePicker.pickFiles(
        type: type,
        allowedExtensions: allowedExtensions,
      );
      files = result
          .where((file) => file.path != null)
          .map((file) => File(file.path!))
          .toList();
    }

    if (files.isNotEmpty && context.mounted) {
      _showDevicePicker(context, files);
    }
  }

  void _showDevicePicker(BuildContext context, List<File> files) {
    final devices = ref.read(deviceListProvider);
    final colorScheme = Theme.of(context).colorScheme;
    
    showModalBottomSheet(
      context: context,
      backgroundColor: CyberColors.surfaceStatic,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'UPLINK TARGET (${files.length} FILES)',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                letterSpacing: 2,
                color: colorScheme.primary,
              ),
            ),
            const SizedBox(height: 24),
            if (devices.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(32),
                  child: Text(
                    'NO NODES DETECTED',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              )
            else
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: devices.length,
                  itemBuilder: (context, index) {
                    final device = devices[index];
                    return ListTile(
                      leading: Icon(
                        _getPlatformIcon(device.platform),
                        color: colorScheme.primary,
                      ),
                      title: Text(
                        device.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        device.ip,
                        style: const TextStyle(
                          fontSize: 10,
                          color: CyberColors.textSecondaryStatic,
                        ),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 14,
                        color: colorScheme.primary,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                TransferScreen(device: device, files: files),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleQrScan(BuildContext context) async {
    final result = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(builder: (context) => const QrScannerScreen()),
    );

    if (result != null) {
      if (!context.mounted) return;
      final device = DiscoveredDevice(
        id: result['ip'],
        name: result['name'],
        ip: result['ip'],
        port: result['port'],
        platform: DevicePlatform.unknown,
        version: 'QR',
        isOnline: true,
        lastSeen: DateTime.now(),
      );
      _handleManualFileSelection(context, device);
    }
  }

  Future<void> _handleManualIp(BuildContext context) async {
    final controller = TextEditingController();
    final colorScheme = Theme.of(context).colorScheme;
    
    final result = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: CyberColors.surfaceStatic,
        title: Text('DIRECT UPLINK', style: TextStyle(color: colorScheme.primary, fontSize: 16)),
        content: TextField(
          controller: controller,
          autofocus: true,
          style: TextStyle(color: colorScheme.primary),
          decoration: const InputDecoration(
            hintText: 'Enter target IP address',
            hintStyle: TextStyle(color: Colors.white24),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: CyberColors.glassStatic),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CANCEL'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, controller.text),
            child: const Text('CONNECT'),
          ),
        ],
      ),
    );

    if (result != null && result.isNotEmpty) {
      final device = DiscoveredDevice(
        id: result,
        name: 'MANUAL NODE',
        ip: result,
        port: AppConfig.defaultTcpPort,
        platform: DevicePlatform.unknown,
        version: 'MANUAL',
        isOnline: true,
        lastSeen: DateTime.now(),
      );
      if (!context.mounted) return;
      _handleManualFileSelection(context, device);
    }
  }

  Future<void> _handleManualFileSelection(
    BuildContext context,
    DiscoveredDevice targetDevice,
  ) async {
    final result = await FilePicker.pickFiles();
    if (result.isEmpty) return;
    final files = result
        .where((file) => file.path != null)
        .map((file) => File(file.path!))
        .toList();

    if (context.mounted && files.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              TransferScreen(device: targetDevice, files: files),
        ),
      );
    }
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.wifi_tethering, size: 64, color: CyberColors.glassStatic),
          SizedBox(height: 16),
          Text(
            'SCANNING SPECTRUM...',
            style: TextStyle(
              fontSize: 14,
              color: CyberColors.textSecondaryStatic,
              letterSpacing: 2,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Ensure remote nodes are visible',
            style: TextStyle(fontSize: 10, color: Colors.white24),
          ),
        ],
      ),
    );
  }

  Widget _buildDeviceList(
    BuildContext context,
    List<DiscoveredDevice> devices,
    ColorScheme colors,
  ) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: devices.length,
      itemBuilder: (context, index) {
        final device = devices[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          color: CyberColors.surfaceStatic,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
              color: device.isOnline
                  ? colors.primary.withValues(alpha: 0.3)
                  : CyberColors.glassStatic,
            ),
          ),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: CyberColors.backgroundStatic,
              child: Icon(
                _getPlatformIcon(device.platform),
                color: device.isOnline
                    ? colors.primary
                    : CyberColors.textSecondaryStatic,
              ),
            ),
            title: Text(
              device.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
            subtitle: Text(
              '${device.ip} • ${device.platform.name.toUpperCase()}',
              style: const TextStyle(fontSize: 10),
            ),
            trailing: Icon(
              Icons.chevron_right,
              color: colors.primary,
            ),
            onTap: device.isOnline
                ? () => _handleManualFileSelection(context, device)
                : null,
          ),
        );
      },
    );
  }

  IconData _getPlatformIcon(DevicePlatform platform) {
    switch (platform) {
      case DevicePlatform.android:
        return Icons.android;
      case DevicePlatform.windows:
        return Icons.laptop_windows;
      case DevicePlatform.linux:
        return Icons.computer;
      case DevicePlatform.macos:
        return Icons.laptop_mac;
      case DevicePlatform.ios:
        return Icons.phone_iphone;
      default:
        return Icons.device_unknown;
    }
  }
}
