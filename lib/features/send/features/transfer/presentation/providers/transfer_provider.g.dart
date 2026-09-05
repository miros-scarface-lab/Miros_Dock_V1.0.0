// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$transferRepositoryHash() =>
    r'2c89130cfde2ccfc0e35ba870431cf0f8d2d9b78';

/// See also [transferRepository].
@ProviderFor(transferRepository)
final transferRepositoryProvider =
    AutoDisposeProvider<TransferRepository>.internal(
  transferRepository,
  name: r'transferRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$transferRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef TransferRepositoryRef = AutoDisposeProviderRef<TransferRepository>;
String _$sendProgressHash() => r'0ecc37a4918fe2f37186225cbd8a539d3abfefe3';

/// See also [sendProgress].
@ProviderFor(sendProgress)
final sendProgressProvider = AutoDisposeStreamProvider<double>.internal(
  sendProgress,
  name: r'sendProgressProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$sendProgressHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SendProgressRef = AutoDisposeStreamProviderRef<double>;
String _$sendStateHash() => r'd874f1106abe8167a84e7846a96a0e178a0690d1';

/// See also [SendState].
@ProviderFor(SendState)
final sendStateProvider =
    AutoDisposeNotifierProvider<SendState, SenderStep>.internal(
  SendState.new,
  name: r'sendStateProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$sendStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SendState = AutoDisposeNotifier<SenderStep>;
String _$receiveStateHash() => r'a775f964295927b98d5924f0bc634a4de0e54afc';

/// See also [ReceiveState].
@ProviderFor(ReceiveState)
final receiveStateProvider =
    AutoDisposeNotifierProvider<ReceiveState, IncomingTransfer?>.internal(
  ReceiveState.new,
  name: r'receiveStateProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$receiveStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ReceiveState = AutoDisposeNotifier<IncomingTransfer?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
