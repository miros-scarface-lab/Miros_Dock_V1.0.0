import '../entities/device.dart';

abstract class DiscoveryRepository {
  Stream<DiscoveredDevice> get deviceStream;
  Future<void> startDiscovery(String deviceName);
  Future<void> stopDiscovery();
  Future<void> advertise(String deviceName);
}



