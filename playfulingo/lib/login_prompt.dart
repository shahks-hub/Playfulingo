import 'package:flutter/material.dart';
import 'package:playfulingo/signup_page.dart';

bool checkUser() {
  return true;
}

class LoginPrompt extends StatelessWidget {
  const LoginPrompt({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: SafeArea(
          child: Column(
        children: [
          const SizedBox(height: 50),
          Image.asset('assets/sample_logo.png', height: 80),
          const SizedBox(height: 50),
          const Text('Welcome to Playfulingo!',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),

          // needs separation for better look
          const SizedBox(height: 30),
          const TextField(
              decoration: InputDecoration(
            labelText: 'Username',
            border: OutlineInputBorder(),
          )),
          const SizedBox(height: 30),
          const TextField(
            decoration: InputDecoration(
              labelText: 'Password',
              border: OutlineInputBorder(),
            ),
            obscureText: true, // hides password
          ),
          const SizedBox(height: 35),
          ElevatedButton(
              onPressed: () {
                checkUser(); // need to implement
              },
              child: const Text('Login')),
          const SizedBox(height: 20),
          const Text(" New User? ",
              style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SignupPage()),
              );
            },
            child: const Text('Go to Sign Up'),
          ),
        ],
      )),
    ));
  }
}
