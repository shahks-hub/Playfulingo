import 'package:flutter/material.dart';
import 'tutorial.dart';

class AbcTutorial extends StatelessWidget {
  final List<String> alphabets = ['A', 'B', 'C', 'D', 'E']; //... add all

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Learn ABCs')),
      body: GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        DetailScreen(alphabet: alphabets[index])),
              );
            },
            child: Card(
              child: Center(
                  child:
                      Text(alphabets[index], style: TextStyle(fontSize: 40))),
            ),
          );
        },
        itemCount: alphabets.length,
      ),
    );
  }
}
