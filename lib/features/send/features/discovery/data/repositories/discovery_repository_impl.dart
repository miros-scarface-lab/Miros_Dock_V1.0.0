import 'dart:async';
import '../../domain/entities/device.dart';
import '../../domain/repositories/discovery_repository.dart';
import '../datasources/udp_discovery_datasource.dart';
import '../datasources/mdns_discovery_datasource.dart';

class DiscoveryRepositoryImpl implements DiscoveryRepository {
  final UdpDiscoveryDataSource _udpDataSource;
  final MdnsDiscoveryDataSource _mdnsDataSource;
  
  final _deviceController = StreamController<DiscoveredDevice>.broadcast();

  DiscoveryRepositoryImpl({
    required UdpDiscoveryDataSource udpDataSource,
    required MdnsDiscoveryDataSource mdnsDataSource,
  })  : _udpDataSource = udpDataSource,
        _mdnsDataSource = mdnsDataSource {
    _udpDataSource.deviceStream.listen(_deviceController.add);
    _mdnsDataSource.deviceStream.listen(_deviceController.add);
  }

  @override
  Stream<DiscoveredDevice> get deviceStream => _deviceController.stream;

  @override
  Future<void> startDiscovery(String deviceName) async {
    await _udpDataSource.start(deviceName);
    await _mdnsDataSource.start(deviceName);
  }

  @override
  Future<void> stopDiscovery() async {
    await _udpDataSource.stop();
    await _mdnsDataSource.stop();
  }

  @override
  Future<void> advertise(String deviceName) async {
    await _udpDataSource.advertise(deviceName);
    await _mdnsDataSource.advertise(deviceName);
  }
}










































