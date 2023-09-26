import 'package:flutter/material.dart';


class ASLQuiz extends StatefulWidget {
  const ASLQuiz({super.key});

  @override
  _ASLQuizState createState() => _ASLQuizState();
}

class _ASLQuizState extends State<ASLQuiz> {
  int currentQuestionIndex = 0;
  int score = 0;

  // Define a list of ASL signs and quiz questions.
  List<ASLQuizItem> quizItems = [
    ASLQuizItem(
      question: "What does this ASL sign mean?",
      signImage: "assets/hello.png", // Replace with your image path
      correctAnswer: "HELLO",
      options: ["HELLO", "GOODBYE", "YES", "NO"],
    ),
    ASLQuizItem(
      question: "What does this ASL sign mean?",
      signImage: "assets/thank_you.png", // Replace with your image path
      correctAnswer: "THANK YOU",
      options: ["HELLO", "THANK YOU", "GOOD MORNING", "YES"],
    ),
    // Add more quiz items here.
  ];

  void checkAnswer(String selectedOption) {
    String correctAnswer = quizItems[currentQuestionIndex].correctAnswer;

    if (selectedOption == correctAnswer) {
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
        title: const Text("ASL Quiz"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              quizItems[currentQuestionIndex].question,
              style: const TextStyle(fontSize: 20.0),
            ),
            const SizedBox(height: 20.0),
            Image.asset(
              quizItems[currentQuestionIndex].signImage,
              width: 200.0,
              height: 200.0,
            ),
            const SizedBox(height: 20.0),
            Column(
              children: quizItems[currentQuestionIndex]
                  .options
                  .map((option) => ElevatedButton(
                        onPressed: () => checkAnswer(option),
                        child: Text(option),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class ASLQuizItem {
  final String question;
  final String signImage;
  final String correctAnswer;
  final List<String> options;

  ASLQuizItem({
    required this.question,
    required this.signImage,
    required this.correctAnswer,
    required this.options,
  });
}