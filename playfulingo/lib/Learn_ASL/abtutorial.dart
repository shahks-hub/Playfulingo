import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AbcTutorial extends StatefulWidget {
  @override
  _AbcTutorialState createState() => _AbcTutorialState();
}

class _AbcTutorialState extends State<AbcTutorial> {
  final List<String> alphabets = [
    'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M',
    'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'
  ];
  String selectedAlphabet = 'A';
  Map<String, bool> tappedAlphabets = {}; // To track tapped alphabets
  bool isFirstTimeCompleted = true; // To track if lesson is completed for the first time

  Future<void> _addCompletedLesson(String lessonId) async {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      final userRef = FirebaseFirestore.instance.collection('users').doc(currentUser.uid);
      try {
        DocumentSnapshot<Map<String, dynamic>> userSnapshot = await userRef.get();
        if (userSnapshot.exists) {
          List<dynamic> completedLessons = userSnapshot.data()?['completed_lessons'] ?? [];
          if (!completedLessons.contains(lessonId)) {
            completedLessons.add(lessonId);
            await userRef.update({'completed_lessons': completedLessons});
            print('Lesson added to completed lessons');
            if (isFirstTimeCompleted) {
              isFirstTimeCompleted = false;
              _showCompletionDialog(); // Show the completion dialog for the first time
            }
          } else {
            print('Lesson already exists in completed lessons');
          }
        }
      } catch (e) {
        print('Error adding lesson to completed lessons: $e');
      }
    }
  }

  void _checkCompleteLesson() {
    if (tappedAlphabets.length == alphabets.length) {
      _addCompletedLesson('abc_tap');
    }
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Congratulations!'),
          content: Text('Lesson completed and Alphabet Drag Drop game unlocked!'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print("map: $tappedAlphabets");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[100],
        title: const Text(
          'Tap to see a sign',
          style: TextStyle(
            color: Colors.purple,
            fontSize: 30.0,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Center(
              child: Image.asset(
                'assets/sign_pics/$selectedAlphabet.PNG',
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemBuilder: (context, index) {
                final currentAlphabet = alphabets[index];
                final isTapped = tappedAlphabets.containsKey(currentAlphabet) ? tappedAlphabets[currentAlphabet]! : true;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedAlphabet = alphabets[index];
                      if (!tappedAlphabets.containsKey(currentAlphabet)) {
                        tappedAlphabets[currentAlphabet] = true;
                        _checkCompleteLesson();
                      }
                    });
                  },
                  child: Card(
                    color: selectedAlphabet == alphabets[index]
                        ? Colors.purple[100]
                        : Colors.pink[800],
                    child: Center(
                      child: Text(
                        alphabets[index],
                        style: TextStyle(
                          fontSize: 40,
                          color: selectedAlphabet == alphabets[index]
                              ? Colors.black
                              : Colors.white,
                        ),
                      ),
                    ),
                  ),
                );
              },
              itemCount: alphabets.length,
            ),
          ),
        ],
      ),
    );
  }
}
