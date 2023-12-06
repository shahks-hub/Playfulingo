import 'package:flutter/material.dart';
import 'package:playfulingo/Games/fill_in_the_blanks.dart';
import 'package:playfulingo/Games/multiple_choice.dart';
import 'package:playfulingo/Games/yes_no.dart';
import 'alphabet_match.dart';
import 'package:gradient_like_css/gradient_like_css.dart';


class GameItem extends StatelessWidget {
  final String title;
  final String image;
  final Widget nextScreen;

  const GameItem(
      {super.key,
      required this.title,
      required this.image,
      required this.nextScreen});

  @override
  Widget build(BuildContext context) {
    
    return ElevatedButton(
      onPressed: () {
        // Navigate to the desired screen when the button is pressed
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => nextScreen,
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        backgroundColor: Colors.white,
      ),
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(image),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.5),
              BlendMode.lighten,
            ),
          ),
          border: Border.all(color: Colors.black, width: 0.0),
          borderRadius: BorderRadius.circular(20.0),
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.white, Colors.red],
          ),
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.red,
              fontSize: 35.0,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  blurRadius: 4.0,
                  color: Colors.black,
                  offset: Offset(2.0, 2.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(' Let us practice now'),
        backgroundColor: Colors.black,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: linearGradient(45, ['blue', 'green', 'blue']),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.count(
            crossAxisCount: 2, // Two columns
            mainAxisSpacing: 20.0,
            crossAxisSpacing: 20.0,
            children: <Widget>[
               const GameItem(
              title: 'Multiple Choice',
              image: 'assets/multiple-choice.png',
              nextScreen: multipleChoice(),
            ),
            GameItem(
                title: 'Fill In The Blanks',
                image: 'assets/fill_in_the blank.png',
                nextScreen: FillInTheBlank()
            ),
            GameItem(
                title: 'yes_or_no',
                image: 'assets/yes_or_no.png',
                nextScreen: YesNoGame()
            ),
            GameItem(
              title: 'Alphabet Drag Drop Match',
              image: 'assets/AR.jpg',
              nextScreen: ASLMatchingGame()
            )
            ],
          ),
        ),
      ),
    );
  }
}







// class GameScreen extends StatelessWidget {
//   const GameScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Playfulingo'),
//         backgroundColor: Colors.black,
//       ),
//       body: Padding(
//         padding:  const EdgeInsets.all(8.0),
//         child: GridView.count(
//           crossAxisCount: 2, // Two columns
//           mainAxisSpacing: 20.0,
//           crossAxisSpacing: 20.0,
//           children:  <Widget>[
//             const GameItem(
//               title: 'Multiple Choice',
//               image: 'assets/multiple-choice.png',
//               nextScreen: multipleChoice(),
//             ),
//             GameItem(
//                 title: 'Fill In The Blanks',
//                 image: 'assets/fill_in_the blank.png',
//                 nextScreen: FillInTheBlank()
//             ),
//             GameItem(
//                 title: 'yes_or_no',
//                 image: 'assets/yes_or_no.png',
//                 nextScreen: YesNoGame()
//             ),
//             GameItem(
//               title: 'Alphabet Drag and Drop Match',
//               image: 'assets/yes_or_no.png',
//               nextScreen: ASLMatchingGame()
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

