import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:miros_share_and_web_dock/features/send/features/settings/presentation/providers/settings_provider.dart';
import 'package:network_info_plus/network_info_plus.dart';

class QrPairingScreen extends ConsumerWidget {
  const QrPairingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    
    return Scaffold(
      appBar: AppBar(title: const Text('QR Pairing')),
      body: FutureBuilder<String?>(
        future: NetworkInfo().getWifiIP(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          
          final ip = snapshot.data;
          if (ip == null) {
            return const Center(child: Text('Could not determine IP address'));
          }

          final qrData = jsonEncode({
            'name': settings.deviceName,
            'ip': ip,
            'port': settings.tcpPort,
            'type': 'miros_pairing',
          });

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Scan this code on another device', style: TextStyle(fontSize: 18)),
                const SizedBox(height: 24),
                QrImageView(
                  data: qrData,
                  version: QrVersions.auto,
                  size: 250.0,
                  backgroundColor: Colors.white,
                ),
                const SizedBox(height: 24),
                Text('Device: ${settings.deviceName}'),
                Text('IP: $ip'),
              ],
            ),
          );
        },
      ),
    );
  }
}










































