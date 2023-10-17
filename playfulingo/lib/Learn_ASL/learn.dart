import 'package:flutter/material.dart';
import 'abtutorial.dart';

class LearnScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Learn Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Welcome to Learn Screen!',
              style: TextStyle(fontSize: 20.0),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Navigate back to the previous screen
                Navigator.of(context).pop();
              },
              child: const Text('Go Back'),
            ),
            ElevatedButton(
                onPressed: () {
                  // Navigate to ABCtutorial screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AbcTutorial()),
                  );
                },
                child: const Text('Go to ABC tutorial')),
          ],
        ),
      ),
    );
  }
}
