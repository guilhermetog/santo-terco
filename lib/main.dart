import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const SantoTercoApp());
}

class SantoTercoApp extends StatelessWidget {
  const SantoTercoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Santo Terço',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
