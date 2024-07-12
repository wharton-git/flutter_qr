import 'package:flutter/material.dart';
// import 'package:flutter_base_project/pages/login_form.dart';
import 'package:flutter_base_project/pages/accueil.dart';
// import 'package:uno/uno.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QR ENI-FEST',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        useMaterial3: true,
        fontFamily: 'TititlliumWeb',
      ),
      home: const HomePage(),
      darkTheme: ThemeData(
          colorScheme: const ColorScheme.dark(background: Colors.black)),
    );
  }
}
