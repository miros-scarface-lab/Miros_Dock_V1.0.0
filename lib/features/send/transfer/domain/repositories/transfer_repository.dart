import 'dart:io';
import '../entities/transfer_session.dart';

abstract class TransferRepository {
  // Sending
  Stream<double> get sendProgressStream;
  Stream<SenderStep> get senderStepStream;
  Future<void> sendFiles(List<File> files, String targetIp, int targetPort);
  void cancelSend();

  // Receiving
  Stream<IncomingTransfer?> get incomingTransferStream;
  Future<void> startServer();
  void stopServer();
  Future<void> acceptTransfer(String sessionId);
  Future<void> rejectTransfer(String sessionId);
  Future<void> cancelReceive(String sessionId);
}



