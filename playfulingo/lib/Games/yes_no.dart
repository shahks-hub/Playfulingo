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
      image: 'assets/good.png',
      answer: false,
    ),
    YesNoItem(
      question: 'Is this PLEASE?',
      image: 'assets/hello.png',
      answer: false,
    ),
    YesNoItem(
      question: 'Is this SORRY?',
      image: 'assets/sorry.png',
      answer: true,
    ),
    YesNoItem(
      question: 'Is this BAD?',
      image: 'assets/bad.png',
      answer: false,
    ),
    YesNoItem(
      question: 'Is this THANK YOU?',
      image: 'assets/thank_you.png',
      answer: true,
    ),
    YesNoItem(
      question: 'Is this GOOD?',
      image: 'assets/good.png',
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
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.of(context)
                    .pop(); // Return to the previous tab/screen
              },
              child: Text('Back'),
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
        backgroundColor: Colors.blue,
      ),
      backgroundColor: const Color.fromARGB(255, 33, 208, 243),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
