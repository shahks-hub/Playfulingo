import 'package:flutter/material.dart';

class AbcTutorial extends StatefulWidget {
  @override
  _AbcTutorialState createState() => _AbcTutorialState();
}

class _AbcTutorialState extends State<AbcTutorial> {
  final List<String> alphabets = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z'
  ];

  String selectedAlphabet = 'A'; // default selection

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Learn ABCs')),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Center(
              // Display image of selected alphabet
              child: Image.asset('assets/sign_pics/$selectedAlphabet.PNG'),
            ),
          ),
          Expanded(
            flex: 3,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedAlphabet = alphabets[index];
                    });
                  },
                  child: Card(
                    child: Center(
                      child: Text(
                        alphabets[index],
                        style: const TextStyle(fontSize: 40),
                      ),
                    ),
                  ),
                );
              },
              itemCount: alphabets.length,
            ),
          ),
        ],
      ),
    );
  }
}
