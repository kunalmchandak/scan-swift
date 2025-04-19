import 'package:flutter/material.dart';
import 'package:scan_swift/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EdgeIDX',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff00A3E9)),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
