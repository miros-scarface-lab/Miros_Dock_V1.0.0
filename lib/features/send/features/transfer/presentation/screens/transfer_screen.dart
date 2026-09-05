import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miros_share_and_web_dock/features/send/core/theme/app_theme.dart';
import 'package:miros_share_and_web_dock/features/send/features/discovery/domain/entities/device.dart';
import '../providers/transfer_provider.dart';
import '../../domain/entities/transfer_session.dart';

class TransferScreen extends ConsumerStatefulWidget {
  final DiscoveredDevice device;
  final List<File> files;

  const TransferScreen({
    super.key,
    required this.device,
    required this.files,
  });

  @override
  ConsumerState<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends ConsumerState<TransferScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(sendStateProvider.notifier).sendFiles(
            widget.files,
            widget.device.ip,
            widget.device.port,
            alternativeIps: widget.device.ips,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentStep = ref.watch(sendStateProvider);
    final progress = ref.watch(sendProgressProvider).value ?? 0.0;
    final colorScheme = Theme.of(context).colorScheme;

    final isDone = currentStep == SenderStep.complete;
    final isCancelled = currentStep == SenderStep.cancelled;
    final isError = currentStep == SenderStep.error;
    final isWaiting = currentStep == SenderStep.waitingForAccept || 
                     currentStep == SenderStep.connecting || 
                     currentStep == SenderStep.sendingMetadata;

    return Scaffold(
      backgroundColor: CyberColors.backgroundStatic,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: (isDone || isCancelled || isError) ? BackButton(color: colorScheme.primary) : null,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildStatusIcon(currentStep, colorScheme),
              const SizedBox(height: 48),
              Text(
                _getStatusTitle(currentStep),
                style: TextStyle(
                  color: colorScheme.primary, 
                  fontSize: 22, 
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                _getStatusSubtitle(currentStep),
                style: const TextStyle(color: CyberColors.textSecondaryStatic, fontSize: 14),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 64),
              if (!isError && !isDone && !isCancelled) ...[
                ClipRRect(
                  borderRadius: BorderRadius.circular(2),
                  child: LinearProgressIndicator(
                    value: isWaiting ? null : progress,
                    minHeight: 6,
                    backgroundColor: CyberColors.glassStatic,
                    color: isWaiting ? colorScheme.secondary : colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  isWaiting ? 'SECURE HANDSHAKE...' : '${(progress * 100).toStringAsFixed(1)}%',
                  style: TextStyle(
                    color: isWaiting ? colorScheme.secondary : colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 32),
                OutlinedButton.icon(
                  onPressed: () => ref.read(sendStateProvider.notifier).cancel(),
                  icon: const Icon(Icons.close, size: 18),
                  label: const Text('CANCEL UPLINK'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: CyberColors.errorStatic,
                    side: const BorderSide(color: CyberColors.errorStatic),
                  ),
                ),
              ],
              if (isDone || isCancelled || isError)
                Padding(
                  padding: const EdgeInsets.only(top: 48),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(200, 50),
                      backgroundColor: (isError || isCancelled) ? CyberColors.errorStatic : colorScheme.primary,
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: Text((isError || isCancelled) ? 'ABORT' : 'RETURN'),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  String _getStatusTitle(SenderStep step) {
    if (step == SenderStep.error) return 'LINK FAILED';
    if (step == SenderStep.cancelled) return 'UPLINK ABORTED';
    switch (step) {
      case SenderStep.connecting: return 'INITIATING UPLINK';
      case SenderStep.sendingMetadata: return 'PUSHING MANIFEST';
      case SenderStep.waitingForAccept: return 'WAITING FOR ACCESS';
      case SenderStep.streaming: return 'DATA STREAMING';
      case SenderStep.complete: return 'UPLINK SUCCESS';
      default: return 'PREPARING';
    }
  }

  String _getStatusSubtitle(SenderStep step) {
    if (step == SenderStep.error) return 'Uplink terminated prematurely.';
    if (step == SenderStep.cancelled) return 'Operation cancelled by operator.';
    switch (step) {
      case SenderStep.waitingForAccept: 
        return 'The remote node must authorize this packet batch.';
      case SenderStep.streaming: 
        return 'Transmitting ${widget.files.length} encrypted files to ${widget.device.name}.';
      case SenderStep.complete: 
        return 'All data packets have been successfully verified and saved.';
      default: 
        return 'Establishing secure tunnel to ${widget.device.ip}.';
    }
  }

  Widget _buildStatusIcon(SenderStep step, ColorScheme colors) {
    if (step == SenderStep.complete) {
      return const Icon(Icons.verified_user_outlined, color: CyberColors.successStatic, size: 100);
    }
    if (step == SenderStep.error || step == SenderStep.cancelled) {
      return const Icon(Icons.gpp_bad_outlined, color: CyberColors.errorStatic, size: 100);
    }
    
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 140,
          height: 140,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(
              step == SenderStep.waitingForAccept ? colors.secondary : colors.primary
            ),
          ),
        ),
        Icon(
          step == SenderStep.waitingForAccept ? Icons.security_outlined : Icons.sensors, 
          color: step == SenderStep.waitingForAccept ? colors.secondary : colors.primary, 
          size: 50
        ),
      ],
    );
  }
}
