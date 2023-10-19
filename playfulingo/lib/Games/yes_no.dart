import 'package:flutter/material.dart';


class YesNoGame extends StatefulWidget {
  @override
  _YesNoGameState createState() => _YesNoGameState();
}

class _YesNoGameState extends State<YesNoGame> {
  List<Map<String, dynamic>> questions = [
    {
      'image': 'assets/thank_you.png', // Load image from assets folder
      'question': 'Is this HELLO?',
      'answer': true,
    },
    {
      'image': 'assets/hello.png', // Load image from assets folder
      'question': 'Is this HELLO?',
      'answer': false,
    },
  ];

  int currentQuestionIndex = 0;
  bool userAnswered = false;
  int score = 0;

  void nextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        userAnswered = false;
      });
    } else {
      // Game over
      showGameOverDialog();
    }
  }

  void checkAnswer(bool answer) {
    if (questions[currentQuestionIndex]['answer'] == answer) {
      // Correct answer
      setState(() {
        score++;
      });
    }
    setState(() {
      userAnswered = true;
    });
  }

  void restartGame() {
    setState(() {
      currentQuestionIndex = 0;
      userAnswered = false;
      score = 0;
    });
  }

  Future<void> showGameOverDialog() async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Game Over'),
          content: Text('Your Score: $score / ${questions.length}'),
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
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Yes or No Game'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                questions[currentQuestionIndex]['image'], // Use AssetImage to load from assets
                width: 200,
                height: 200,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  questions[currentQuestionIndex]['question'],
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              if (!userAnswered)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () => checkAnswer(true),
                      child: Text('Yes'),
                    ),
                    SizedBox(width: 20.0),
                    ElevatedButton(
                      onPressed: () => checkAnswer(false),
                      child: Text('No'),
                    ),
                  ],
                ),
              if (userAnswered)
                ElevatedButton(
                  onPressed: nextQuestion,
                  child: Text('Next'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
