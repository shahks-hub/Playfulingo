import 'package:flutter/material.dart';
import 'package:playfulingo/Games/fill_in_the_blanks.dart';
import 'package:playfulingo/Games/multiple_choice.dart';
import 'package:playfulingo/Games/yes_no.dart';
import 'alphabet_match.dart';
import 'package:gradient_like_css/gradient_like_css.dart';
import 'alphabet_prac.dart';
import 'package:playfulingo/HomePage/dash.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:playfulingo/Firebase/firebase_functions.dart'; 
import 'package:firebase_auth/firebase_auth.dart';





class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
     final currentUser = FirebaseAuth.instance.currentUser;
     return FutureBuilder<List<String>>(
      future: fetchCompletedLessons(currentUser?.email ?? ''),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Loading indicator while fetching data
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final completedLessons = Set.from(snapshot.data ?? []);

    return Scaffold(
      appBar: AppBar(
         iconTheme: IconThemeData(
      color: Colors.blue, // Change the color of the back arrow here
    ),
        title: const Text(
          'Practice make perfect', 
          style: TextStyle(
            color: Colors.orange,
            fontSize: 30.0,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
            ),),
        backgroundColor: Colors.black,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: linearGradient(45, ['blue', 'green', 'red']),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.count(
            crossAxisCount: 2, // Two columns
            mainAxisSpacing: 20.0,
            crossAxisSpacing: 20.0,
            children: <Widget>[
               const GameItem(
              title: 'Multiple Choice',
              unlockedImage: 'assets/multiple-choice.png',
              lockedImage:  'assets/lock.png'  ,
              nextScreen: multipleChoice(),
               isUnlocked: true, 
            ),
            GameItem(
                title: 'Fill In The Blanks',
               unlockedImage:  'assets/fill_in_the blank.png'  ,
               lockedImage:  'assets/lock.png'  ,
                nextScreen: FillInTheBlank(),
                 isUnlocked: true, 
            ),
            GameItem(
                title: 'yes_or_no',
                unlockedImage: 'assets/yes_or_no.png',
                lockedImage:    'assets/lock.png' ,
                nextScreen: YesNoGame(),
                 isUnlocked: true, 
            ),
            GameItem(
              title: 'Alphabet Drag Drop Match',
              unlockedImage: 'assets/flashcard.png' ,
              lockedImage:   'assets/lock.png' ,
              nextScreen: ASLMatchingGame(),
               isUnlocked: completedLessons.contains('x3BsaHPxcvmBoQLroe0I'), 
            ),
              GameItem(
                title: 'Snap and Prac',
                unlockedImage: 'assets/learn_bg.png',
                lockedImage:   'assets/lock.png' ,
                nextScreen: CameraScreen(),
                 isUnlocked: completedLessons.contains('x3BsaHPxcvmBoQLroe0I'), 
            ),
         
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Dash(),
                  ),
                );
              },
              child: Text(
                'Go back to homepage', 
                style: TextStyle(
                fontSize: 20,
                
              ),
                  
              ),
              style: ElevatedButton.styleFrom(
    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12), // Button padding
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(80), // Button border shape
    ),
    primary: Colors.orange[300], // Background color
    onPrimary: Colors.blue, // Text color
              ),),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
class GameItem extends StatelessWidget {
  final String title;
  final String? unlockedImage;
  final String? lockedImage;
  final Widget nextScreen;
  final bool isUnlocked;

  const GameItem({
    required this.title,
    required this.unlockedImage,
    required this.lockedImage,
    required this.nextScreen,
    required this.isUnlocked,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isUnlocked
          ? () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => nextScreen,
                ),
              );
            }
          : null,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        backgroundColor: Colors.white,
      ),
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(isUnlocked ? unlockedImage! : lockedImage!),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.5),
              BlendMode.lighten,
            ),
          ),
          border: Border.all(color: Colors.black, width: 0.0),
          borderRadius: BorderRadius.circular(20.0),
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.white, Colors.red],
          ),
        ),
        child: isUnlocked
            ? Center(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 30.0,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        blurRadius: 4.0,
                        color: Colors.black,
                        offset: Offset(2.0, 2.0),
                      ),
                    ],
                  ),
                ),
              )
            : Center(
                child: Icon(
                  Icons.lock,
                  size: 40,
                  color: Colors.black87,
                ),
              ),
      ),
    );
  }
}
