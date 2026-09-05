import '../entities/protocol_packet.dart';

enum SenderStep { idle, connecting, sendingMetadata, waitingForAccept, streaming, complete, error, cancelled }

enum TransferStatus { waiting, transferring, completed, error, cancelled }

class IncomingTransfer {
  final String sessionId;
  final BatchMetadata batchMetadata;
  final FileMetadata? currentFileMetadata;
  final TransferStatus status;
  final double progress;
  final String? error;
  final List<String> savedPaths;

  IncomingTransfer({
    required this.sessionId,
    required this.batchMetadata,
    this.currentFileMetadata,
    required this.status,
    required this.progress,
    this.error,
    required this.savedPaths,
  });

  IncomingTransfer copyWith({
    FileMetadata? currentFileMetadata,
    TransferStatus? status,
    double? progress,
    String? error,
    List<String>? savedPaths,
  }) {
    return IncomingTransfer(
      sessionId: sessionId,
      batchMetadata: batchMetadata,
      currentFileMetadata: currentFileMetadata ?? this.currentFileMetadata,
      status: status ?? this.status,
      progress: progress ?? this.progress,
      error: error ?? this.error,
      savedPaths: savedPaths ?? this.savedPaths,
    );
  }
}



