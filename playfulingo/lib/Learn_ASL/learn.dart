import 'package:flutter/material.dart';
import 'package:playfulingo/Learn_ASL/flashcard.dart';
import 'abtutorial.dart';
import 'abcvideo.dart';

class LearnScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Learn Screen'),
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Welcome to Learn Screen!',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.red,
                ),
              ),
              SizedBox(height: 10.0),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AbcTutorial()),
                  );
                },
                child: Container(
                  width: 200,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black, width: 10.0),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Center(
                    child: Text(
                      'ABC tutorial',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FlashcardScreen(flashcards: flashcards)),
                  );
                },
                child: Container(
                  width: 200,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black, width: 10.0),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Center(
                    child: Text(
                      'ABC flashcards',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              // SizedBox(height: 10.0),
              // GestureDetector(
              //   onTap: () {
              //     // Navigator.push(
              //     //   context,
              //     //   // MaterialPageRoute(builder: (context) => AbcVideoPage()),
              //     // );
              //   },
                // child: Container(
                //   width: 200,
                //   height: 100,
                //   decoration: BoxDecoration(
                //     color: Colors.white,
                //     border: Border.all(color: Colors.black, width: 10.0),
                //     borderRadius: BorderRadius.circular(20.0),
                //   ),
                  // child: Center(
                  //   child: Text(
                  //     'ABC Video',
                  //     style: TextStyle(
                  //       color: Colors.red,
                  //       fontSize: 24.0,
                  //       fontWeight: FontWeight.bold,
                  //     ),
                  //   ),
                  // ),
               // ),
             // ),
            ],
          ),
        ),
      ),
    );
  }
}
