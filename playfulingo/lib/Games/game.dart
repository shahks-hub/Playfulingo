import 'package:flutter/material.dart';
import 'alphabet_match.dart';
import 'package:gradient_like_css/gradient_like_css.dart';
import 'alphabet_prac.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:playfulingo/HomePage/dash.dart';
import 'package:playfulingo/Firebase/firebase_functions.dart';


class GameItem extends StatelessWidget {
  final String title;
  final Widget nextScreen;
  final String? unlockedImage;
  final String? lockedImage;
  final bool isUnlocked;

  const GameItem({
    Key? key,
    required this.title,
    required this.nextScreen,
    required this.unlockedImage,
    required this.lockedImage,
    required this.isUnlocked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isUnlocked
          ? () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => nextScreen,
                ),
              );
            }
          : null,
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
            image: AssetImage(isUnlocked ? unlockedImage! : lockedImage!),
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
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (!isUnlocked)
              Icon(
                Icons.lock,
                size: 40,
                color: Colors.black87,
              ),
            Center(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.orange,
                  fontSize: 40.0,
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
          ],
        ),
      ),
    );
  }
}

class GameScreen extends StatelessWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    return FutureBuilder<List<String>>(
      future: fetchCompletedLessons(currentUser?.email ?? ''),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final completedLessons = Set.from(snapshot.data ?? []);

          return Scaffold(
            appBar: AppBar(
              iconTheme: const IconThemeData(
                color: Colors.blue,
              ),
              title: const Center(
                child: Text(
                  'Practice',
                  style: TextStyle(
                    color: Colors.orange,
                    fontSize: 30.0,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              backgroundColor: Colors.black,
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_forward),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Dash()),
                    );
                  },
                ),
              ],
            ),
            body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: linearGradient(45, ['blue', 'green', 'blue']),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: GridView.count(
                  crossAxisCount: 1,
                  mainAxisSpacing: 20.0,
                  crossAxisSpacing: 20.0,
                  childAspectRatio: 1.2,
                  children: <Widget>[
                    GameItem(
                      title: 'Alphabet Drag Drop',
                      unlockedImage: 'assets/flashcard.png',
                      lockedImage: 'assets/lock.png',
                      nextScreen: ASLMatchingGame(),
                      isUnlocked: true,
                    ),
                    GameItem(
                      title: 'Alphabet Snap',
                      unlockedImage: 'assets/learnbg2.jpg',
                      lockedImage: 'assets/lock.png',
                      nextScreen: CameraScreen(),
                      isUnlocked: completedLessons.contains('abc_video'),
                      // isUnlocked: true,
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}


