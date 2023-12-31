import 'package:flutter/material.dart';
import 'package:playfulingo/Games/game.dart';
import 'package:playfulingo/Learn_ASL/learn.dart';
import 'package:gradient_like_css/gradient_like_css.dart';
import 'progress.dart';

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
        backgroundColor:
            Colors.transparent, // Change to a transparent background
      ),
      child: Center(
        child: Container(
          height: 500, // Adjust the height of the grid items
          width: 200, // Adjust the width of the grid items
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
        ),
      ),
    );
  }
}

class Dash extends StatelessWidget {
  const Dash({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Playfulingo',
          style: TextStyle(
            color: Colors.orange,
            fontSize: 35.0,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: linearGradient(45, ['blue', 'purple', 'orange']),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: GridView.count(
                  crossAxisCount: 2, // Two columns
                  mainAxisSpacing: 20.0,
                  crossAxisSpacing: 20.0,
                  childAspectRatio:
                      0.3, // Adjust the aspect ratio of the grid items
                  children: <Widget>[
                    Center(
                      child: DashboardItem(
                        title: 'Learn',
                        image: 'assets/learn_bg.png',
                        nextScreen: Learn(),
                      ),
                    ),
                    Center(
                      child: DashboardItem(
                        title: 'Games',
                        image: 'assets/multiple-choice.png',
                        nextScreen: GameScreen(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            color: Colors
                .black, // Background color for the section containing the buttons
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ProgressPage(),
                        ),
                      );
                    },
                    child: Text('Your Progress'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Show the instructions pop-up box when the button is pressed
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('App Instructions'),
                            content: Text(
                                'This app is for us to learn ASL together! There is a learn section and another one with games and activities for you to practice. some games are locked until you complete corresponding lessons. '),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Text('Instructions'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
