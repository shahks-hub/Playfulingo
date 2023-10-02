import 'dart:async';
import 'package:flutter/material.dart';


class MemoryMatchingGame extends StatefulWidget {
  const MemoryMatchingGame({super.key});

  @override
  _MemoryMatchingGameState createState() => _MemoryMatchingGameState();
}

class _MemoryMatchingGameState extends State<MemoryMatchingGame> {
  List<String> images = [
    "assets/hello.png",
    "assets/hello.png",
    "assets/hello.png",
    // Add more image file names
  ];

  List<String> texts = [
    "Text1",
    "Text2",
    "Text3",
    // Add more text data
  ];

  List<String> cards = [];

  int? firstCardIndex;
  int? secondCardIndex;

  bool isMatching = false;

  @override
  void initState() {
    super.initState();
    cards = List.from(images)..addAll(texts);
    cards.shuffle();
  }

  void _onCardTap(int index) {
    if (!isMatching && (firstCardIndex == null || secondCardIndex == null)) {
      setState(() {
        if (firstCardIndex == null) {
          firstCardIndex = index;
        } else {
          secondCardIndex = index;
          _checkMatch();
        }
      });
    }
  }

  void _checkMatch() {
    isMatching = true;
    if (cards[firstCardIndex!] == cards[secondCardIndex!]) {
      // Matched
      Timer(const Duration(seconds: 1), () {
        setState(() {
          firstCardIndex = null;
          secondCardIndex = null;
          isMatching = false;
        });
      });
    } else {
      // Not matched
      Timer(const Duration(seconds: 1), () {
        setState(() {
          firstCardIndex = null;
          secondCardIndex = null;
          isMatching = false;
        });
      });

      _showNotMatchDialog();
    }
  }

  void _showNotMatchDialog() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Not a Match"),
        content: Text("Try again!"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("OK"),
          ),
        ],
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Memory Matching Game'),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
        ),
        itemBuilder: (context, index) {
          return Card(
            child: InkWell(
              onTap: () {
                if (firstCardIndex != index && secondCardIndex != index) {
                  _onCardTap(index);
                }
              },
              child: Center(
                child: Text(
                  cards[index],
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
        itemCount: cards.length,
      ),
    );
  }
}
