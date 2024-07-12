import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Generate(),
    );
  }
}

class Generate extends StatelessWidget {
  const Generate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Générateur de QR Code'),
      ),
      body: const Center(
        child: TextForm(),
      ),
    );
  }
}

class TextForm extends StatefulWidget {
  const TextForm({super.key});

  @override
  _TextFormState createState() => _TextFormState();
}

class _TextFormState extends State<TextForm> {
  final _controller = TextEditingController();
  String _inputText = "";
  final ScreenshotController _screenshotController = ScreenshotController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _generateQR() {
    setState(() {
      _inputText = _controller.text;
    });
  }

  Future<void> _saveQRCode() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }

    if (await Permission.storage.isGranted) {
      final directory = await getExternalStorageDirectory();
      final filePath = '${directory!.path}/qr_code.png';
      _screenshotController.captureAndSave(directory.path, fileName: "qr_code.png").then((File? image) {
        if (image != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('QR Code enregistré à $filePath')),
          );
        }
      } as FutureOr Function(String? value));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Permission de stockage refusée')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
            controller: _controller,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Entrez du texte',
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _generateQR,
            child: const Text('Générer QR'),
          ),
          const SizedBox(height: 20),
          if (_inputText.isNotEmpty)
            Screenshot(
              controller: _screenshotController,
              child: QrImageView(
                data: _inputText,
                version: QrVersions.auto,
                size: 200.0,
              ),
            ),
          const SizedBox(height: 20),
          if (_inputText.isNotEmpty)
            ElevatedButton(
              onPressed: _saveQRCode,
              child: const Text('Enregistrer QR Code'),
            ),
        ],
      ),
    );
  }
}
