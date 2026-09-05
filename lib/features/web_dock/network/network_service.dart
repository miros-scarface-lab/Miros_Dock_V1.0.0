import 'dart:io';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:logging/logging.dart';

enum NetworkType { wifi, ethernet, mobile, other }

class NetworkInterfaceInfo {
  final String name;
  final String ip;
  final NetworkType type;

  NetworkInterfaceInfo({
    required this.name,
    required this.ip,
    required this.type,
  });
}

class NetworkService {
  final _logger = Logger('NetworkService');
  final _info = NetworkInfo();
  final _connectivity = Connectivity();

  Stream<ConnectivityResult> get onConnectivityChanged =>
      _connectivity.onConnectivityChanged.map(
        (results) => results.isEmpty ? ConnectivityResult.none : results.first,
      );

  Future<List<NetworkInterfaceInfo>> getAvailableInterfaces() async {
    List<NetworkInterfaceInfo> interfaces = [];
    try {
      final networkInterfaces = await NetworkInterface.list(
        includeLoopback: false,
        type: InternetAddressType.IPv4,
      );

      for (var interface in networkInterfaces) {
        for (var addr in interface.addresses) {
          if (addr.type == InternetAddressType.IPv4) {
            interfaces.add(
              NetworkInterfaceInfo(
                name: interface.name,
                ip: addr.address,
                type: _determineType(interface.name),
              ),
            );
          }
        }
      }
    } catch (e) {
      _logger.severe('Failed to get network interfaces: $e');
    }
    return interfaces;
  }

  NetworkType _determineType(String name) {
    final lowerName = name.toLowerCase();
    if (lowerName.contains('wi-fi') || lowerName.contains('wlan')) {
      return NetworkType.wifi;
    }
    if (lowerName.contains('ethernet') || lowerName.contains('eth')) {
      return NetworkType.ethernet;
    }
    if (lowerName.contains('rmnet')) return NetworkType.mobile;
    return NetworkType.other;
  }

  Future<String?> getWifiIP() async {
    return await _info.getWifiIP();
  }

  Future<String?> getWifiName() async {
    return await _info.getWifiName();
  }
}



