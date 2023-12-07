import 'package:flutter/material.dart';

class ASLFlashcard {
  final String aslSignAsset;
  final String englishWord;

  ASLFlashcard({
    required this.aslSignAsset,
    required this.englishWord,
  });
}

List<ASLFlashcard> flashcards = [
  ASLFlashcard(
    aslSignAsset: 'assets/hello.png',
    englishWord: 'HELLO',
  ),
  ASLFlashcard(
    aslSignAsset: 'assets/thank_you.png',
    englishWord: 'Thank You',
  ),
  ASLFlashcard(
    aslSignAsset: 'assets/please.png',
    englishWord: 'Please',
  ),
  ASLFlashcard(
    aslSignAsset: 'assets/sorry.png',
    englishWord: 'Sorry',
  ),
  ASLFlashcard(
    aslSignAsset: 'assets/good.png',
    englishWord: 'Good',
  ),
  ASLFlashcard(
    aslSignAsset: 'assets/bad.png',
    englishWord: 'Bad',
  ),
];

class FlashcardScreen extends StatefulWidget {
  final List<ASLFlashcard> flashcards;
  int currentIndex = 0;

  FlashcardScreen({super.key, required this.flashcards});

  @override
  _FlashcardScreenState createState() => _FlashcardScreenState();
}

class _FlashcardScreenState extends State<FlashcardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ASL Flashcards'),
        backgroundColor: Colors.blue,
      ),
      backgroundColor: const Color.fromARGB(255, 33, 208, 243),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              widget.flashcards[widget.currentIndex].aslSignAsset,
              height: 200,
              width: 200,
            ),
            SizedBox(height: 20),
            Text(
              widget.flashcards[widget.currentIndex].englishWord,
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    // Show the previous flashcard
                    if (widget.currentIndex > 0) {
                      setState(() {
                        widget.currentIndex--;
                      });
                    }
                  },
                  child: Text('Previous'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Show the next flashcard
                    if (widget.currentIndex < widget.flashcards.length - 1) {
                      setState(() {
                        widget.currentIndex++;
                      });
                    }
                  },
                  child: Text('Next'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
