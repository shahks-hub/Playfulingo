import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:playfulingo/Firebase/firebase_functions.dart'; 
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class AbcVideoPage extends StatefulWidget {
  @override
  _AbcVideoPageState createState() => _AbcVideoPageState();
}

class _AbcVideoPageState extends State<AbcVideoPage> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: 'T4FKufhMc44',
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[300],
        iconTheme: IconThemeData(
          color: Colors.white, // Change the color of the back arrow here
        ),
        title: const Text(
          'ABC Video', 
          style: TextStyle(
            color: Colors.white,
            fontSize: 30.0,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: YoutubePlayerBuilder(
          player: YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
            progressIndicatorColor: Colors.blueAccent,
            onReady: () {
              // Do something on video ready
            },
            onEnded: (YoutubeMetaData metaData) {
              _addCompletedLesson('abc_video');
            },
          ),
          builder: (context, player) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                player,
                SizedBox(height: 16.0),
                Text(
                  _controller.metadata.title ?? '',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Future<void> _addCompletedLesson(String lessonId) async {
    // Your function code from firebase_functions.dart
    final currentUser = FirebaseAuth.instance.currentUser;
    bool isFirstTimeCompleted = true; // To track if lesson is completed for the first time

    if (currentUser != null) {
      final userRef = FirebaseFirestore.instance.collection('users').doc(currentUser.uid);
      // print("userred: $userRef");
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

  void _showCompletionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Congratulations!'),
          content: Text('Lesson completed and Snap Recog game unlocked!'),
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
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
