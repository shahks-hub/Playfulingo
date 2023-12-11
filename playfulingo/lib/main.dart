import 'package:flutter/material.dart';
import 'package:playfulingo/StartUp/animated_splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:playfulingo/Games/alphabet_prac.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await dotenv.load(fileName: ".env");

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
