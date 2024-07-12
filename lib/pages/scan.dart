import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class Scan extends StatefulWidget {
  const Scan({super.key});

  @override
  State<Scan> createState() => _Scan();
}

class _Scan extends State<Scan> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  // Barcode? value;

  void _onQRViewCreated(QRViewController contr) {
    controller = contr;
    contr.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  void _copy() {
    if (result?.code != null) {
      var value = result?.code;
      Clipboard.setData(ClipboardData(text: value!));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Texte copié')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez scanner un code d\'abord')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          flex: 2,
          child: QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
          ),
        ),
        Expanded(
            flex: 1,
            child: Center(
              child: (result != null)
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton.icon(
                              icon: const Icon(Icons.flash_on),
                              label: const Text('Flash'),
                              onPressed: () {},
                            ),
                            const SizedBox(width: 30),
                            ElevatedButton.icon(
                              icon: const Icon(Icons.copy),
                              label: const Text('Copy'),
                              onPressed: () {
                                _copy();
                              },
                            ),
                            // ElevatedButton(),
                          ],
                        ),
                        const SizedBox(height: 50),
                        Text(
                            'Barcode Type: ${describeIdentity(result!.format)}'),
                        const SizedBox(height: 20),
                        Text(
                          'Data: ${result!.code}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                  : const Text('Scan a code...'),
            ))
      ],
    ));
  }
}
