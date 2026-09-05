import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:miros_share_and_web_dock/features/send/core/config/app_config.dart';
import 'package:miros_share_and_web_dock/features/send/core/utils/logger.dart';
import '../../domain/entities/device.dart';
import 'package:uuid/uuid.dart';

class UdpDiscoveryDataSource {
  final _deviceController = StreamController<DiscoveredDevice>.broadcast();
  RawDatagramSocket? _socket;
  Timer? _advertiseTimer;
  final _uuid = const Uuid().v4();

  Stream<DiscoveredDevice> get deviceStream => _deviceController.stream;

  Future<void> start(String deviceName) async {
    try {
      _socket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, AppConfig.defaultUdpPort);
      _socket?.broadcastEnabled = true;
      _socket?.multicastLoopback = false;

      _socket?.listen((RawSocketEvent event) {
        if (event == RawSocketEvent.read) {
          final datagram = _socket?.receive();
          if (datagram != null) {
            _handlePacket(datagram);
          }
        }
      });

      advertise(deviceName);
      _advertiseTimer = Timer.periodic(AppConfig.discoveryInterval, (_) => advertise(deviceName));
      logger.i('UDP Discovery started on port ${AppConfig.defaultUdpPort}');
    } catch (e) {
      logger.e('Failed to start UDP Discovery: $e');
    }
  }

  Future<void> stop() async {
    _advertiseTimer?.cancel();
    _socket?.close();
    _socket = null;
    logger.i('UDP Discovery stopped');
  }

  Future<void> advertise(String deviceName) async {
    try {
      final interfaces = await NetworkInterface.list(
        includeLinkLocal: false, 
        type: InternetAddressType.IPv4
      );

      for (var interface in interfaces) {
        for (var addr in interface.addresses) {
          final packet = {
            'id': _uuid,
            'name': deviceName,
            'ip': addr.address,
            'port': AppConfig.defaultTcpPort,
            'platform': _getPlatform().name,
            'version': AppConfig.appVersion,
          };

          final data = utf8.encode(jsonEncode(packet));
          _socket?.send(data, InternetAddress('255.255.255.255'), AppConfig.defaultUdpPort);
          _socket?.send(data, InternetAddress('224.0.0.1'), AppConfig.defaultUdpPort);
        }
      }
    } catch (e) {
      logger.e('Error during UDP advertisement: $e');
    }
  }

  void _handlePacket(Datagram datagram) {
    try {
      final data = utf8.decode(datagram.data);
      final json = jsonDecode(data) as Map<String, dynamic>;
      
      if (json['id'] == _uuid) return;

      final device = DiscoveredDevice.fromJson(json);
      _deviceController.add(device);
    } catch (e) {
      // Ignore malformed packets
    }
  }

  DevicePlatform _getPlatform() {
    if (Platform.isAndroid) return DevicePlatform.android;
    if (Platform.isWindows) return DevicePlatform.windows;
    if (Platform.isLinux) return DevicePlatform.linux;
    if (Platform.isMacOS) return DevicePlatform.macos;
    if (Platform.isIOS) return DevicePlatform.ios;
    return DevicePlatform.unknown;
  }
}



