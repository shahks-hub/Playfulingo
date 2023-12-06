import 'package:flutter/material.dart';
import 'package:playfulingo/Games/game.dart';
import 'package:playfulingo/Learn_ASL/learn.dart';
import 'package:playfulingo/gesture_detection/gesture.dart';
import 'package:gradient_like_css/gradient_like_css.dart';

class DashboardItem extends StatelessWidget {
  final String title;
  final String image;
  final Widget nextScreen;

  const DashboardItem(
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
            gradient: linearGradient(50, ['blue', 'white', 'red']),
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
        ));
  }
}

// need to add settings option

class Dash extends StatelessWidget {
  const Dash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Playfulingo'),
        backgroundColor: Colors.black,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: linearGradient(45, ['blue', 'black', 'purple']),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.count(
            crossAxisCount: 2, // Two columns
            mainAxisSpacing: 20.0,
            crossAxisSpacing: 20.0,
            children: <Widget>[
              DashboardItem(
                title: 'Learn',
                image: 'assets/learn_bg.png',
                nextScreen: Learn()),
              DashboardItem(
                  title: 'Practice',
                  image: 'assets/practice.png',
                  nextScreen: GestureScreen()),
              DashboardItem(
                  title: 'Games',
                  image: 'assets/sample_logo.png',
                  nextScreen: GameScreen()),
            ],
          ),
        ),
      ),
    );
  }
}
