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
      appBar: AppBar(
         iconTheme: IconThemeData(
      color: Colors.blue, // Change the color of the back arrow here
    ),
        title: const Text(
          'Tap to see a sign', 
          style: TextStyle(
            color: Colors.orange,
            fontSize: 30.0,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
            ),),),
        
      
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
                     color: selectedAlphabet == alphabets[index]
                    ? Colors.orange // Change the color based on selection
                        : Colors.blue, // Default color for unselected items
                    child: Center(
                      child: Text(
                        alphabets[index],
                        style:  TextStyle(
                          fontSize: 40,
                          color: selectedAlphabet == alphabets[index]
                              ? Colors.black // Change the text color based on selection
                              : Colors.white, // Default color for unselected items
                          ),
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
