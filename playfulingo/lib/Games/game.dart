import 'package:flutter/material.dart';
import 'package:playfulingo/Learn_ASL/flashcard.dart';
import 'package:playfulingo/Games/multiple_choice.dart';
import 'package:playfulingo/Games/yes_no.dart';

class GameItem extends StatelessWidget {
  final String title;
  final String image;
  final Widget nextScreen;

  const GameItem(
      {super.key,
      required this.title,
      required this.image,
      required this.nextScreen});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          // Navigate to the desired screen when the button is pressed
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => nextScreen,
            ),
          );
        },
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
                image: AssetImage(image),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.5),
                  BlendMode.lighten,
                ),
              ),
              border: Border.all(color: Colors.black, width: 10.0),
              borderRadius: BorderRadius.circular(20.0)),
          child: Center(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 35.0,
                fontStyle: FontStyle.italic,
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
          ),
        ));
  }
}




class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Playfulingo'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding:  const EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisCount: 2, // Two columns
          mainAxisSpacing: 20.0,
          crossAxisSpacing: 20.0,
          children:  <Widget>[
            const GameItem(
              title: 'Multiple Choice',
              image: 'assets/multiple-choice.png',
              nextScreen: multipleChoice(),
            ),
            GameItem(
                title: 'Flashcard',
                image: 'assets/flashcard.png',
                nextScreen: FlashcardScreen(flashcards: flashcards)
            ),
            GameItem(
                title: 'yes_or_no',
                image: 'assets/yes_or_no.png',
                nextScreen: YesNoGame()
            ),
          ],
        ),
      ),
    );
  }
}

