// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discovery_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$discoveryRepositoryHash() =>
    r'2c533cd9e905e33052c44f1be788f9215ae89f91';

/// See also [discoveryRepository].
@ProviderFor(discoveryRepository)
final discoveryRepositoryProvider =
    AutoDisposeProvider<DiscoveryRepository>.internal(
  discoveryRepository,
  name: r'discoveryRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$discoveryRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef DiscoveryRepositoryRef = AutoDisposeProviderRef<DiscoveryRepository>;
String _$deviceListHash() => r'517f37c1a8caa4280489dd0942077de22e8ffb4c';

/// See also [DeviceList].
@ProviderFor(DeviceList)
final deviceListProvider =
    AutoDisposeNotifierProvider<DeviceList, List<DiscoveredDevice>>.internal(
  DeviceList.new,
  name: r'deviceListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$deviceListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$DeviceList = AutoDisposeNotifier<List<DiscoveredDevice>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
