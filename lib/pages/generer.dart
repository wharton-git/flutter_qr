import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class Generer extends StatefulWidget {
  const Generer({super.key});

  @override
  State<Generer> createState() => _Generer();
}

class _Generer extends State<Generer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: QrImageView(
        data: 'Mandrindra suce Wharton',
        version: QrVersions.auto,
        size: 2000.0,
      ),
    );
  }
}
