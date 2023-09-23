import 'package:flutter/material.dart';
import 'package:playfulingo/animated_splash.dart';

void main() {
  runApp(const Playfulingo());
}

class Playfulingo extends StatelessWidget {
  const Playfulingo({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: AnimatedSplash(), // animated spash
    );
  }
}
