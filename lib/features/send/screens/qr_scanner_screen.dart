import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrScannerScreen extends StatefulWidget {
  const QrScannerScreen({super.key});

  @override
  State<QrScannerScreen> createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends State<QrScannerScreen> {
  bool _found = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scan QR Code')),
      body: MobileScanner(
        onDetect: (capture) {
          if (_found) return;
          final List<Barcode> barcodes = capture.barcodes;
          for (final barcode in barcodes) {
            final code = barcode.rawValue;
            if (code != null) {
              try {
                final data = jsonDecode(code);
                if (data['type'] == 'miros_pairing') {
                  setState(() => _found = true);
                  Navigator.pop(context, data);
                  break;
                }
              } catch (e) {
                // Not a valid Miros QR code
              }
            }
          }
        },
      ),
    );
  }
}










































