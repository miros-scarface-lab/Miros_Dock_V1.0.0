import 'dart:async';
import 'package:bonsoir/bonsoir.dart';
import 'package:miros_share_and_web_dock/features/send/core/config/app_config.dart';
import 'package:miros_share_and_web_dock/features/send/core/utils/logger.dart';
import '../../domain/entities/device.dart';
import 'dart:io';

class MdnsDiscoveryDataSource {
  final _deviceController = StreamController<DiscoveredDevice>.broadcast();
  BonsoirBroadcast? _broadcast;
  BonsoirDiscovery? _discovery;

  Stream<DiscoveredDevice> get deviceStream => _deviceController.stream;

  Future<void> start(String deviceName) async {
    final service = BonsoirService(
      name: deviceName,
      type: AppConfig.mDnsServiceName,
      port: AppConfig.defaultTcpPort,
      attributes: {
        'platform': _getPlatformName(),
        'version': AppConfig.appVersion,
      },
    );

    try {
      _broadcast = BonsoirBroadcast(service: service);
      _broadcast!.start();
      logger.i('mDNS Advertisement started');
    } catch (e) {
      logger.w('mDNS Broadcast error: $e');
    }

    try {
      _discovery!.eventStream!.listen((event) {
        if (event.service != null) {
          final s = event.service!;
          final List<String> allIps = s.hostAddresses;
          
          final device = DiscoveredDevice(
            id: s.name,
            name: s.name,
            ip: allIps.firstOrNull ?? s.toJson()['host'] ?? '',
            ips: allIps,
            port: s.port,
            platform: DevicePlatform.fromString(s.attributes['platform'] ?? 'unknown'),
            version: s.attributes['version'] ?? '1.0.0',
            isOnline: true,
            lastSeen: DateTime.now(),
          );
          _deviceController.add(device);
        }
      });
      _discovery!.start();
      logger.i('mDNS Discovery started');
    } catch (e) {
      logger.w('mDNS Discovery error: $e');
    }
  }

  Future<void> stop() async {
    await _broadcast?.stop();
    await _discovery?.stop();
  }

  Future<void> advertise(String deviceName) async {}

  String _getPlatformName() {
    if (Platform.isAndroid) return 'android';
    if (Platform.isWindows) return 'windows';
    if (Platform.isLinux) return 'linux';
    if (Platform.isMacOS) return 'macos';
    if (Platform.isIOS) return 'ios';
    return 'unknown';
  }
}










































