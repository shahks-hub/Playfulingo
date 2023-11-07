import 'package:flutter/material.dart';

class FillInTheBlank extends StatefulWidget {
  const FillInTheBlank({Key? key}) : super(key: key);

  @override
  _FillInTheBlankState createState() => _FillInTheBlankState();
}

class _FillInTheBlankState extends State<FillInTheBlank> {
  int currentQuestionIndex = 0;
  int score = 0;

  // Define a list of ASL quiz questions with picture options.
  List<FillInTheBlankItem> quizItems = [
    FillInTheBlankItem(
      question: "__ How are you?",
      correctAnswer: 1, // Index of the correct picture (0 or 1).
      options: [
        "assets/hello.png", // Option 0: Replace with your image path.
        "assets/good.png",  // Option 1: Replace with your image path.
      ],
    ),
    FillInTheBlankItem(
      question: "__ for your help.",
      correctAnswer: 0, // Index of the correct picture (0 or 1).
      options: [
        "assets/thank_you.png",  // Option 0: Replace with your image path.
        "assets/sorry.png",    // Option 1: Replace with your image path.
      ],
    ),
    // Add more quiz items here.
  ];

  void checkAnswer(int selectedOptionIndex) {
    int correctAnswerIndex = quizItems[currentQuestionIndex].correctAnswer;

    if (selectedOptionIndex == correctAnswerIndex) {
      setState(() {
        score++;
      });
    }

    // Move to the next question.
    setState(() {
      if (currentQuestionIndex < quizItems.length - 1) {
        currentQuestionIndex++;
      } else {
        // Display a score dialog when all questions are answered.
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Quiz Completed"),
              content: Text("Your Score: $score / ${quizItems.length}"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    setState(() {
                      currentQuestionIndex = 0;
                      score = 0;
                    });
                  },
                  child: const Text("Restart"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    // Return to the previous screen or navigate to the dashboard.
                    // You can replace the following line with your desired navigation action.
                    Navigator.pop(context);
                  },
                  child: const Text("Back"),
                ),
              ],
            );
          },
        );
      }
    });
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text("FillInTheBlank"),
    ),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            quizItems[currentQuestionIndex].question,
            style: const TextStyle(fontSize: 20.0),
          ),
          const SizedBox(height: 20.0), // Add space below the question.
          Column(
            children: List.generate(quizItems[currentQuestionIndex].options.length, (index) {
              return Column(
                children: [
                  ElevatedButton(
                    onPressed: () => checkAnswer(index),
                    child: Image.asset(quizItems[currentQuestionIndex].options[index]),
                  ),
                  const SizedBox(height: 10.0), // Add space between answer options.
                ],
              );
            }),
          ),
        ],
      ),
    ),
  );
}
}

class FillInTheBlankItem {
  final String question;
  final int correctAnswer;
  final List<String> options;

  FillInTheBlankItem({
    required this.question,
    required this.correctAnswer,
    required this.options,
  });
}
