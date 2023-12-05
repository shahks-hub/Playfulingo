import 'package:flutter/material.dart';
import 'alphabet_prac.dart';// Import your alphabet practice screen

class GestureScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gesture Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome to Gesture Screen!',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Navigate to the Alphabet Practice Screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CameraScreen()), // Replace with your Alphabet Practice Screen widget
                );
              },
              child: Text('Go to Alphabet Practice'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Navigate back to the previous screen
                Navigator.of(context).pop();
              },
              child: Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}
