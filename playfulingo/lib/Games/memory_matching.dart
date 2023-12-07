import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class MemoryMatchingGame extends StatefulWidget {
  @override
  _MemoryMatchingGameState createState() => _MemoryMatchingGameState();
}

class _MemoryMatchingGameState extends State<MemoryMatchingGame> {
  late List<String> imagePaths;
  late List<String> shuffledImages;
  late List<bool> isCardFlipped;
  late List<bool> isCardMatched;
  int previousIndex = -1;
  bool isGameComplete = false;
  bool isWaiting = false;

  @override
  void initState() {
    super.initState();
    initializeGame();
  }

  void initializeGame() {
    imagePaths = [
      'assets/hello.png',
      'assets/sorry.png',
      'assets/bad.png',
      'assets/good.png',
      'assets/please.png',
      'assets/thank_you.png',
      // Add more image paths as needed
    ];

    shuffledImages = List<String>.from(imagePaths)..addAll(imagePaths);
    shuffledImages.shuffle();

    isCardFlipped = List<bool>.filled(shuffledImages.length, false);
    isCardMatched = List<bool>.filled(shuffledImages.length, false);
    previousIndex = -1;
    isGameComplete = false;
    isWaiting = false;
  }

  void resetGame() {
    setState(() {
      initializeGame();
    });
  }

  void flipCard(int index) {
    setState(() {
      if (isWaiting || isCardMatched[index]) {
        // Do nothing if waiting or if the card is already matched
        return;
      }

      isCardFlipped[index] = true;

      if (previousIndex == -1) {
        previousIndex = index;
      } else {
        if (shuffledImages[previousIndex] == shuffledImages[index]) {
          isCardMatched[previousIndex] = true;
          isCardMatched[index] = true;

          if (!isCardMatched.contains(false)) {
            // All cards are matched, game complete
            isGameComplete = true;
          }
          previousIndex = -1; // Reset previousIndex after a successful match
        } else {
          isWaiting = true; // Set the flag to indicate waiting
          // Wait for a moment and then flip back the unmatched cards
          Future.delayed(Duration(seconds: 1), () {
            setState(() {
              isCardFlipped[previousIndex] = false;
              isCardFlipped[index] = false;
              previousIndex = -1;
              isWaiting = false; // Reset the flag after the timer
            });
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Memory Matching Game'),
        backgroundColor: Colors.blue,
      ),
      backgroundColor: const Color.fromARGB(255, 33, 208, 243),
      body: Center(
        child: isGameComplete
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Congratulations! You won!',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: resetGame,
                    child: Text('Play Again'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Return to the previous tab/screen
                      Navigator.of(context).pop();
                    },
                    child: Text('Back'),
                  ),
                ],
              )
            : GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemCount: shuffledImages.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      if (!isCardFlipped[index] && !isCardMatched[index]) {
                        flipCard(index);
                      }
                    },
                    child: Card(
                      color: isCardFlipped[index] || isCardMatched[index]
                          ? Colors.blue
                          : Colors.grey,
                      child: Center(
                        child: isCardFlipped[index] || isCardMatched[index]
                            ? Image.asset(
                                shuffledImages[index],
                                height: 450,
                                width: 450,
                              )
                            : Icon(Icons.image),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
