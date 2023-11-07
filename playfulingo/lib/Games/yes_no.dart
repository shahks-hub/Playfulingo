import 'package:flutter/material.dart';

class YesNoGame extends StatefulWidget {
  @override
  _YesNoGameState createState() => _YesNoGameState();
}

class _YesNoGameState extends State<YesNoGame> {
  int currentQuestionIndex = 0;
  int score = 0;

  List<YesNoItem> yesNoItems = [
    YesNoItem(
      question: 'Is this HELLO?',
      image: 'assets/hello.png',
      answer: true,
    ),
    YesNoItem(
      question: 'Is this THANK YOU?',
      image: 'assets/thank_you.png',
      answer: false,
    ),
  ];

  void checkAnswer(bool answer) {
    bool correctAnswer = yesNoItems[currentQuestionIndex].answer;

    if (answer == correctAnswer) {
      setState(() {
        score++;
      });
    }

    // Move to the next question.
    setState(() {
      if (currentQuestionIndex < yesNoItems.length - 1) {
        currentQuestionIndex++;
      } else {
        // Display a score dialog when all questions are answered.
        showGameOverDialog();
      }
    });
  }

  void restartGame() {
    setState(() {
      currentQuestionIndex = 0;
      score = 0;
    });
  }

  Future<void> showGameOverDialog() async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Game Over'),
          content: Text('Your Score: $score / ${yesNoItems.length}'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                restartGame();
              },
              child: Text('Restart'),
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
        title: Text('Yes or No Game'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.asset(
              yesNoItems[currentQuestionIndex].image,
              width: 200,
              height: 200,
            ),
            SizedBox(height: 20.0),
            Text(
              yesNoItems[currentQuestionIndex].question,
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () => checkAnswer(true),
              child: Text('Yes'),
            ),
            SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () => checkAnswer(false),
              child: Text('No'),
            ),
          ],
        ),
      ),
    );
  }
}

class YesNoItem {
  final String question;
  final String image;
  final bool answer;

  YesNoItem({
    required this.question,
    required this.image,
    required this.answer,
  });
}
