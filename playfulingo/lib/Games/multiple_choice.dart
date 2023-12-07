import 'package:flutter/material.dart';
import 'package:playfulingo/HomePage/dash.dart';

class multipleChoice extends StatefulWidget {
  const multipleChoice({super.key});

  @override
  _multipleChoiceState createState() => _multipleChoiceState();
}

class _multipleChoiceState extends State<multipleChoice> {
  int currentQuestionIndex = 0;
  int score = 0;

  // Define a list of ASL signs and quiz questions.
  List<multipleChoiceItem> quizItems = [
    multipleChoiceItem(
      question: "What does this ASL sign mean?",
      signImage: "assets/hello.png", // Replace with your image path
      correctAnswer: "HELLO",
      options: ["HELLO", "GOODBYE", "YES", "NO"],
    ),
    multipleChoiceItem(
      question: "What does this ASL sign mean?",
      signImage: "assets/thank_you.png", // Replace with your image path
      correctAnswer: "THANK YOU",
      options: ["HELLO", "THANK YOU", "GOOD MORNING", "YES"],
    ),
    multipleChoiceItem(
      question: "What does this ASL sign mean?",
      signImage: "assets/sorry.png", // Replace with your image path
      correctAnswer: "SORRY",
      options: ["OKAY", "YES", "PLEASE", "SORRY"],
    ),
    multipleChoiceItem(
      question: "What does this ASL sign mean?",
      signImage: "assets/bad.png", // Replace with your image path
      correctAnswer: "BAD",
      options: ["LOVE", "BAD", "CORRECT", "GOOD"],
    ),
    multipleChoiceItem(
      question: "What does this ASL sign mean?",
      signImage: "assets/please.png", // Replace with your image path
      correctAnswer: "PLEASE",
      options: ["PLEASE", "THANK YOU", "SORRY", "NO"],
    ),
    multipleChoiceItem(
      question: "What does this ASL sign mean?",
      signImage: "assets/good.png", // Replace with your image path
      correctAnswer: "GOOD",
      options: ["FRIEND", "NAME", "NEXT", "GOOD"],
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
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.pop(context); // Return to the previous screen (Dash)
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
        title: const Text("Multiple Choice"),
        backgroundColor: Colors.blue,
      ),
      backgroundColor: const Color.fromARGB(255, 33, 208, 243),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min, // Ensure minimum vertical space.
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
      ),
    );
  }
}

class multipleChoiceItem {
  final String question;
  final String signImage;
  final String correctAnswer;
  final List<String> options;

  multipleChoiceItem({
    required this.question,
    required this.signImage,
    required this.correctAnswer,
    required this.options,
  });
}