import 'package:flutter/material.dart';
import 'package:playfulingo/quiz.dart';

class Dash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dashboard')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Successfully logged in or signed up!'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ASLQuiz()), // Navigate to ASLQuiz
                );
              },
              child: Text('Start ASL Quiz'),
            ),
          ],
        ),
      ),
    );
  }
}