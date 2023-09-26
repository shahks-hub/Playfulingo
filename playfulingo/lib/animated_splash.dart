import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:playfulingo/login_prompt.dart';

class AnimatedSplash extends StatelessWidget {
  const AnimatedSplash({super.key});
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        children: [
          Center(child: Image.asset('assets/sample_logo.png')),
        ],
      ),
      nextScreen: const LoginPrompt(),
      splashIconSize: 303,
      duration: 3000,
      splashTransition: SplashTransition.scaleTransition,
    );
  }
}
