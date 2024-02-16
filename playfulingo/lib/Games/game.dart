// import 'package:flutter/material.dart';
// import 'package:playfulingo/Games/fill_in_the_blanks.dart';
// import 'package:playfulingo/Games/memory_matching.dart';
// import 'package:playfulingo/Games/multiple_choice.dart';
// import 'package:playfulingo/Games/yes_no.dart';
// import 'alphabet_match.dart';
// import 'package:gradient_like_css/gradient_like_css.dart';
// import 'alphabet_prac.dart';
// import 'package:playfulingo/HomePage/dash.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:playfulingo/Firebase/firebase_functions.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:playfulingo/HomePage/glass_morph.dart';
// import 'package:playfulingo/Games/gesture.dart';
// import 'package:google_fonts/google_fonts.dart';

// class GameScreen extends StatelessWidget {
//   const GameScreen({super.key});
//   @override
//   Widget build(BuildContext context) {
//     final currentUser = FirebaseAuth.instance.currentUser;
//     return FutureBuilder<List<String>>(
//       future: fetchCompletedLessons(currentUser?.email ?? ''),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return CircularProgressIndicator(); // Loading indicator while fetching data
//         } else if (snapshot.hasError) {
//           return Text('Error: ${snapshot.error}');
//         } else {
//           final completedLessons = Set.from(snapshot.data ?? []);

//           return Scaffold(
//             appBar: AppBar(
//               iconTheme: const IconThemeData(
//                 color: Colors.blue, // Change the color of the back arrow here
//               ),
//               title: Center(
//                 child: Text(
//                   'Practice ASL',
//                   style: GoogleFonts.novaSquare(
//                     color: Colors.orange,
//                     fontSize: 30.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               backgroundColor: Colors.black,
//               actions: <Widget>[
//              IconButton(
//             icon: Icon(Icons.arrow_forward),
//             onPressed: () {
              
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => Dash()),
//               );
//             },
//           ),
//         ],
//             ),
//             body: Container(
//               decoration: const BoxDecoration(
//                 image: DecorationImage(
//                   image: AssetImage("assets/gamebg.jpg"),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               alignment: const Alignment(0, 0),
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         GlassMorph(
//                           title: "SignChoice",
//                           isUnlocked: true,
//                           lockedImage: 'assets/lock.png',
//                           mChild: Column(
//                             children: [
//                               ElevatedButton(
//                                 onPressed: () {
//                                   Navigator.of(context).push(MaterialPageRoute(
//                                     builder: (context) =>
//                                         const multipleChoice(),
//                                   ));
//                                 },
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: Colors.transparent,
//                                   elevation: 0,
//                                 ),
//                                 child: Image.asset(
//                                   "assets/multiplechoice.png",
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         GlassMorph(
//                           title: "BlankSign",
//                           isUnlocked: true,
//                           lockedImage: 'assets/lock.png',
//                           mChild: Column(
//                             children: [
//                               ElevatedButton(
//                                 onPressed: () {
//                                   Navigator.of(context).push(MaterialPageRoute(
//                                     builder: (context) =>
//                                         const FillInTheBlank(),
//                                   ));
//                                 },
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: Colors.transparent,
//                                   elevation: 0,
//                                 ),
//                                 child: Image.asset(
//                                   "assets/blank.png",
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
                        
//                       ],
//                     ),
//                     const SizedBox(height: 20), // Add space between rows
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         GlassMorph(
//                           title: "SignJudge",
//                           isUnlocked: true,
//                           lockedImage: 'assets/lock.png',
//                           mChild: Column(
//                             children: [
//                               ElevatedButton(
//                                 onPressed: () {
//                                   Navigator.of(context).push(MaterialPageRoute(
//                                     builder: (context) => YesNoGame(),
//                                   ));
//                                 },
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: Colors.transparent,
//                                   elevation: 0,
//                                 ),
//                                 child: Image.asset(
//                                   "assets/yes_no.png",
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         GlassMorph(
//                           title: "Matcher",
//                           isUnlocked: completedLessons.contains('abc_tap'),
//                           lockedImage: 'assets/lock.png',
//                           mChild: Column(
//                             children: [
//                               ElevatedButton(
//                                 onPressed: () {
//                                   if (completedLessons.contains('abc_tap')) {
//                                     Navigator.of(context)
//                                         .push(MaterialPageRoute(
//                                       builder: (context) => ASLMatchingGame(),
//                                     ));
//                                   }
//                                 },
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: Colors.transparent,
//                                   elevation: 0,
//                                 ),
//                                 child: Image.asset(
//                                   "assets/connect.png",
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 20), // Add space between rows
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         GlassMorph(
//                           title: "ImageInfer",
//                           isUnlocked: completedLessons.contains('abc_video'),
//                           lockedImage: 'assets/lock.png',
//                           mChild: Column(
//                             children: [
//                               ElevatedButton(
//                                 onPressed: () {
//                                   if (completedLessons.contains('abc_video')) {
//                                     Navigator.of(context)
//                                         .push(MaterialPageRoute(
//                                       builder: (context) => CameraScreen(),
//                                     ));
//                                   }
//                                 },
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: Colors.transparent,
//                                   elevation: 0,
//                                 ),
//                                 child: Image.asset(
//                                   "assets/cam.png",
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         // GlassMorph(
//                         //   title: "Detector",
//                         //   lockedImage: 'assets/lock.png',
//                         //   isUnlocked: true,
//                         //   mChild: Column(
//                         //     children: [
//                         //       ElevatedButton(
//                         //         onPressed: () {
//                         //           Navigator.of(context).push(MaterialPageRoute(
//                         //             builder: (context) => const GestureScreen(),
//                         //           ));
//                         //         },
//                         //         style: ElevatedButton.styleFrom(
//                         //           backgroundColor: Colors.transparent,
//                         //           elevation: 0,
//                         //         ),
//                         //         child: Image.asset(
//                         //           "assets/gesture.png",
//                         //           fit: BoxFit.cover,
//                         //         ),
//                         //       ),
//                         //     ],
//                         //   ),
//                         // ),
//                       ],
//                     ),
//                     const SizedBox(height: 20),
//                     GlassMorph(
//                       title: "GuessMatch",
//                       isUnlocked: true,
//                       lockedImage: 'assets/lock.png',
//                       mChild: Column(
//                         children: [
//                           ElevatedButton(
//                             onPressed: () {
//                               Navigator.of(context).push(MaterialPageRoute(
//                                 builder: (context) => MemoryMatchingGame(),
//                               ));
//                             },
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.transparent,
//                               elevation: 0,
//                             ),
//                             child: Image.asset(
//                               "assets/ASLmatch.png",
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         }
//       },
//     );
//   }
// }

// class GameItem extends StatelessWidget {
//   final String title;
//   final String? unlockedImage;
//   final String? lockedImage;
//   final Widget nextScreen;
//   final bool isUnlocked;

//   const GameItem({
//     required this.title,
//     required this.unlockedImage,
//     required this.lockedImage,
//     required this.nextScreen,
//     required this.isUnlocked,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: isUnlocked
//           ? () {
//               Navigator.of(context).push(
//                 MaterialPageRoute(
//                   builder: (context) => nextScreen,
//                 ),
//               );
//             }
//           : null,
//       style: ElevatedButton.styleFrom(
//         padding: EdgeInsets.zero,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20.0),
//         ),
//         backgroundColor: Colors.white,
//       ),
//       child: Container(
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage(isUnlocked ? unlockedImage! : lockedImage!),
//             fit: BoxFit.cover,
//             colorFilter: ColorFilter.mode(
//               Colors.white.withOpacity(0.5),
//               BlendMode.lighten,
//             ),
//           ),
//           border: Border.all(color: Colors.black, width: 0.0),
//           borderRadius: BorderRadius.circular(20.0),
//           gradient: LinearGradient(
//             colors: [Colors.blue, Colors.white, Colors.red],
//           ),
//         ),
//         child: isUnlocked
//             ? Center(
//                 child: Text(
//                   title,
//                   style: const TextStyle(
//                     color: Colors.red,
//                     fontSize: 30.0,
//                     fontStyle: FontStyle.normal,
//                     fontWeight: FontWeight.bold,
//                     shadows: [
//                       Shadow(
//                         blurRadius: 4.0,
//                         color: Colors.black,
//                         offset: Offset(2.0, 2.0),
//                       ),
//                     ],
//                   ),
//                 ),
//               )
//             : Center(
//                 child: Icon(
//                   Icons.lock,
//                   size: 40,
//                   color: Colors.black87,
//                 ),
//               ),
//       ),
//     );
//   }
// }
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
         iconTheme: IconThemeData(
      color: Colors.blue, // Change the color of the back arrow here
    ),
        title: const Text(
          'Practice make perfect', 
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
              image: 'assets/flashcard.png',
              nextScreen: ASLMatchingGame()
            )
            ],
          ),
        ),
      ),
    );
  }
}





