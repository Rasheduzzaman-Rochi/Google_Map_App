import 'package:flutter/material.dart';
import 'package:google_map/home_screen.dart';

void main() {
  runApp(const googleMapApp());
}

class googleMapApp extends StatelessWidget {
  const googleMapApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: homeScreen(),
    );
  }
}