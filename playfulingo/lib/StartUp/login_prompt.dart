import 'package:flutter/material.dart';
import 'package:playfulingo/StartUp/signup_page.dart';
import 'package:playfulingo/HomePage/dash.dart'; // Ensure you've created this file.
import 'package:firebase_auth/firebase_auth.dart';

class LoginPrompt extends StatefulWidget {
  const LoginPrompt({Key? key}) : super(key: key);

  @override
  _LoginPromptState createState() => _LoginPromptState();
}

class _LoginPromptState extends State<LoginPrompt> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        // avoids renderflow for keyboard
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 50),
              Image.asset('assets/sample_logo.png', height: 80),
              const SizedBox(height: 50),
              const Text('Welcome to Playfulingo!',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black)),
              const SizedBox(height: 30),
              TextField(
                controller: usernameController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true, // hides password
              ),
              const SizedBox(height: 35),
              ElevatedButton(
                onPressed: () async {
                  final emailAddress = usernameController.text.trim();
                  final password = passwordController.text.trim();

                  try {
                    final credential = await _auth.signInWithEmailAndPassword(
                      email: emailAddress,
                      password: password,
                    );

                    const snackBar =
                        SnackBar(content: Text('Successfully logged in!'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);

                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Dash()));
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'user-not-found') {
                      final snackBar = SnackBar(
                          content: Text('No user found for that email.'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else if (e.code == 'wrong-password') {
                      final snackBar = SnackBar(
                          content:
                              Text('Wrong password provided for that user.'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else {
                      final snackBar =
                          SnackBar(content: Text('An error occurred.'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  } catch (e) {
                    print("Error: $e");
                    final snackBar = SnackBar(
                        content: Text('An error occurred. Please try again.'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                child: const Text('Login'),
              ),
              const SizedBox(height: 20),
              const Text("New User?",
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
          ),
        ),
      ),
    );
  }
}
