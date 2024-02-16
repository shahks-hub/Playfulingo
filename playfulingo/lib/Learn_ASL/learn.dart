// import 'package:flutter/material.dart';
// import 'package:playfulingo/Learn_ASL/flashcard.dart';
// import 'package:playfulingo/HomePage/learning_morph.dart';
// import 'abtutorial.dart';
// import 'abcvideo.dart';
// import 'simpleaslvideo.dart';
// import 'package:google_fonts/google_fonts.dart';

// class Learn extends StatelessWidget {
//   const Learn({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           iconTheme: const IconThemeData(
//             color: Colors.blue, // Change the color of the back arrow here
//           ),
//           title: Center(
//             child: Text(
//               'Learn ASL',
//               style: GoogleFonts.novaSquare(
//                 color: Colors.orange,
//                 fontSize: 30.0,
//                 fontStyle: FontStyle.italic,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           backgroundColor: Colors.black,
//         ),
//         body: Container(
//             decoration: const BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage("assets/learnbg2.jpg"),
//                 fit: BoxFit.cover,
//               ),
//             ),
//             alignment: const Alignment(0, 0),
//             child: SingleChildScrollView(
//                 child: Column(
//               children: [
//                 LearnMorph(
//                   mChild: Column(
//                     children: [
//                       Text(
//                         "Sign Alphabets",
//                         style: GoogleFonts.playfairDisplay(
//                           color: Colors.blue,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 24.0,
//                         ),
//                       ),
//                       const SizedBox(height: 20),
//                       ElevatedButton(
//                         onPressed: () {
//                           Navigator.of(context).push(MaterialPageRoute(
//                             builder: (context) => AbcTutorial(),
//                           ));
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.transparent,
//                           elevation: 0,
//                         ),
//                         child: Image.asset(
//                           "assets/ASLprac.png",
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 40),
//                 LearnMorph(
//                   mChild: Column(
//                     children: [
//                       Text(
//                         "Alphabet Video",
//                         style: GoogleFonts.playfairDisplay(
//                           color: Colors.red,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 24.0,
//                         ),
//                       ),
//                       const SizedBox(height: 40),
//                       ElevatedButton(
//                         onPressed: () {
//                           Navigator.of(context).push(MaterialPageRoute(
//                             builder: (context) => AbcVideoPage(),
//                           ));
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.transparent,
//                           elevation: 0,
//                         ),
//                         child: Image.asset(
//                           "assets/videoplay.png",
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 40),
//                 LearnMorph(
//                   mChild: Column(
//                     children: [
//                       Text(
//                         "Word Video",
//                         style: GoogleFonts.playfairDisplay(
//                           color: Colors.green,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 24.0,
//                         ),
//                       ),
//                       const SizedBox(height: 40),
//                       ElevatedButton(
//                         onPressed: () {
//                           Navigator.of(context).push(MaterialPageRoute(
//                             builder: (context) => BasicASLvideo(),
//                           ));
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.transparent,
//                           elevation: 0,
//                         ),
//                         child: Image.asset(
//                           "assets/words.png",
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 40),
//                 LearnMorph(
//                   mChild: Column(
//                     children: [
//                       Text(
//                         "FLashCards",
//                         style: GoogleFonts.playfairDisplay(
//                           color: Colors.purple,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 24.0,
//                         ),
//                       ),
//                       const SizedBox(height: 40),
//                       ElevatedButton(
//                         onPressed: () {
//                           Navigator.of(context).push(MaterialPageRoute(
//                             builder: (context) =>
//                                 FlashcardScreen(flashcards: flashcards),
//                           ));
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.transparent,
//                           elevation: 0,
//                         ),
//                         child: Image.asset(
//                           "assets/flashcards.png",
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ))));
//   }
// }

import 'package:flutter/material.dart';
import 'package:playfulingo/Learn_ASL/flashcard.dart';
import 'abtutorial.dart';
import 'abcvideo.dart';
import 'simpleaslvideo.dart';
import 'package:gradient_like_css/gradient_like_css.dart';

class LearnboardItem extends StatelessWidget {
  final String title;
  final String image;
  final Widget nextScreen;

  const LearnboardItem(
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



class Learn extends StatelessWidget {
  const Learn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
      color: Colors.blue, // Change the color of the back arrow here
    ),
        title: const Text(
          'Learn tab', 
          style: TextStyle(
            color: Colors.orange,
            fontSize: 30.0,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
            ),),
        backgroundColor: Colors.black,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: linearGradient(45, ['red', 'green', 'blue']),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.count(
            crossAxisCount: 2, // Two columns
            mainAxisSpacing: 20.0,
            crossAxisSpacing: 20.0,
            children: <Widget>[
              LearnboardItem(
                title: 'Abctutorial',
                image: 'assets/learn_bg.png',
                nextScreen: AbcTutorial()),
              LearnboardItem(
                  title: 'abc video',
                  image: 'assets/practice.png',
                  nextScreen: AbcVideoPage()),
              LearnboardItem(
                  title: 'basic asl video',
                  image: 'assets/arbg.png',
                  nextScreen: BasicASLvideo()),
              LearnboardItem(
                  title: 'flash card',
                  image: 'assets/sample_logo.png',
                  nextScreen: FlashcardScreen(flashcards: flashcards)),
            ],
          ),
        ),
      ),
    );
  }
}
