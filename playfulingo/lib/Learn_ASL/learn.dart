import 'package:flutter/material.dart';
import 'package:playfulingo/Learn_ASL/flashcard.dart';
import 'package:playfulingo/HomePage/learning_morph.dart';
import 'abtutorial.dart';
import 'abcvideo.dart';
import 'simpleaslvideo.dart';
import 'package:google_fonts/google_fonts.dart';

class Learn extends StatelessWidget {
  const Learn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.blue, // Change the color of the back arrow here
          ),
          title: Center(
            child: Text(
              'Learn ASL',
              style: GoogleFonts.novaSquare(
                color: Colors.orange,
                fontSize: 30.0,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          backgroundColor: Colors.black,
        ),
        body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/learnbg2.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            alignment: const Alignment(0, 0),
            child: SingleChildScrollView(
                child: Column(
              children: [
                LearnMorph(
                  mChild: Column(
                    children: [
                      Text(
                        "Sign Alphabets",
                        style: GoogleFonts.playfairDisplay(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 24.0,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AbcTutorial(),
                          ));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                        ),
                        child: Image.asset(
                          "assets/ASLprac.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                LearnMorph(
                  mChild: Column(
                    children: [
                      Text(
                        "Alphabet Video",
                        style: GoogleFonts.playfairDisplay(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 24.0,
                        ),
                      ),
                      const SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AbcVideoPage(),
                          ));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                        ),
                        child: Image.asset(
                          "assets/videoplay.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                LearnMorph(
                  mChild: Column(
                    children: [
                      Text(
                        "Word Video",
                        style: GoogleFonts.playfairDisplay(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 24.0,
                        ),
                      ),
                      const SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => BasicASLvideo(),
                          ));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                        ),
                        child: Image.asset(
                          "assets/words.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                LearnMorph(
                  mChild: Column(
                    children: [
                      Text(
                        "FLashCards",
                        style: GoogleFonts.playfairDisplay(
                          color: Colors.purple,
                          fontWeight: FontWeight.bold,
                          fontSize: 24.0,
                        ),
                      ),
                      const SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                FlashcardScreen(flashcards: flashcards),
                          ));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                        ),
                        child: Image.asset(
                          "assets/flashcards.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ))));
  }
}
