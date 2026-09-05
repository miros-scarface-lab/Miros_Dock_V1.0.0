import 'dart:async';
import '../../domain/entities/device.dart';
import '../../domain/repositories/discovery_repository.dart';
import '../../data/repositories/discovery_repository_impl.dart';
import '../../data/datasources/udp_discovery_datasource.dart';
import '../../data/datasources/mdns_discovery_datasource.dart';
import 'package:miros_share_and_web_dock/features/send/features/settings/presentation/providers/settings_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'discovery_provider.g.dart';

@riverpod
DiscoveryRepository discoveryRepository(DiscoveryRepositoryRef ref) {
  return DiscoveryRepositoryImpl(
    udpDataSource: UdpDiscoveryDataSource(),
    mdnsDataSource: MdnsDiscoveryDataSource(),
  );
}

@riverpod
class DeviceList extends _$DeviceList {
  final Map<String, DiscoveredDevice> _devices = {};
  Timer? _cleanupTimer;

  @override
  List<DiscoveredDevice> build() {
    final settings = ref.watch(settingsProvider);
    final repository = ref.watch(discoveryRepositoryProvider);
    
    if (settings.isVisible) {
      repository.startDiscovery(settings.deviceName);
    } else {
      repository.stopDiscovery();
    }
    
    repository.deviceStream.listen(_onDeviceDiscovered);
    
    _cleanupTimer = Timer.periodic(const Duration(seconds: 10), (_) => _cleanupDevices());
    
    ref.onDispose(() {
      repository.stopDiscovery();
      _cleanupTimer?.cancel();
    });

    return [];
  }

  void _onDeviceDiscovered(DiscoveredDevice device) {
    final updatedDevice = device.copyWith(
      lastSeen: DateTime.now(),
      isOnline: true,
    );
    _devices[device.id] = updatedDevice;
    state = _devices.values.toList();
  }

  void _cleanupDevices() {
    final now = DateTime.now();
    bool changed = false;
    
    final keysToRemove = <String>[];
    _devices.forEach((id, device) {
      if (device.lastSeen != null && 
          now.difference(device.lastSeen!).inSeconds > 15) {
        if (device.isOnline) {
          _devices[id] = device.copyWith(isOnline: false);
          changed = true;
        }
      }
      
      if (device.lastSeen != null && 
          now.difference(device.lastSeen!).inMinutes > 2) {
        keysToRemove.add(id);
      }
    });

    for (var key in keysToRemove) {
      _devices.remove(key);
      changed = true;
    }

    if (changed) {
      state = _devices.values.toList();
    }
  }

  void scan() {
    final settings = ref.read(settingsProvider);
    _devices.clear();
    state = [];
    ref.read(discoveryRepositoryProvider).advertise(settings.deviceName);
  }
}



