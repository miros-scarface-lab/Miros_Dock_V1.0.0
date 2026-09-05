import 'dart:io';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/transfer_session.dart';
import '../../domain/repositories/transfer_repository.dart';
import '../../data/repositories/transfer_repository_impl.dart';
import '../../data/datasources/tcp_client_datasource.dart';
import '../../data/datasources/tcp_server_datasource.dart';
import 'package:miros_share_and_web_dock/features/send/features/settings/presentation/providers/settings_provider.dart';

part 'transfer_provider.g.dart';

@riverpod
TransferRepository transferRepository(TransferRepositoryRef ref) {
  final repo = TransferRepositoryImpl(
    client: TcpClientDataSource(),
    server: TcpServerDataSource(),
  );

  // Start server immediately
  repo.startServer();

  ref.onDispose(() {
    repo.stopServer();
  });

  return repo;
}

@riverpod
class SendState extends _$SendState {
  @override
  SenderStep build() {
    final subscription = ref
        .watch(transferRepositoryProvider)
        .senderStepStream
        .listen((step) {
          state = step;
        });
    ref.onDispose(subscription.cancel);
    return SenderStep.idle;
  }

  Future<void> sendFiles(
    List<File> files,
    String targetIp,
    int targetPort, {
    List<String>? alternativeIps,
  }) async {
    await ref
        .read(transferRepositoryProvider)
        .sendFiles(files, targetIp, targetPort, alternativeIps: alternativeIps);
  }

  void cancel() {
    ref.read(transferRepositoryProvider).cancelSend();
  }
}

@riverpod
Stream<double> sendProgress(SendProgressRef ref) {
  return ref.watch(transferRepositoryProvider).sendProgressStream;
}

@riverpod
class ReceiveState extends _$ReceiveState {
  @override
  IncomingTransfer? build() {
    final repo = ref.watch(transferRepositoryProvider);
    final subscription = repo.incomingTransferStream.listen((transfer) {
      state = transfer;

      // Auto-accept logic
      if (transfer != null && transfer.status == TransferStatus.waiting) {
        final settings = ref.read(settingsProvider);
        if (settings.autoAccept) {
          accept();
        }
      }
    });
    ref.onDispose(subscription.cancel);
    return null;
  }

  Future<void> accept() async {
    if (state == null) return;
    await ref.read(transferRepositoryProvider).acceptTransfer(state!.sessionId);
  }

  Future<void> reject() async {
    if (state == null) return;
    await ref.read(transferRepositoryProvider).rejectTransfer(state!.sessionId);
  }

  Future<void> cancel() async {
    if (state == null) return;
    await ref.read(transferRepositoryProvider).cancelReceive(state!.sessionId);
  }

  void dismiss() {
    state = null;
  }
}



