import 'package:flutter/material.dart';
import 'dart:math';
import 'game.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ASLMatchingGame extends StatefulWidget {
  @override
  _ASLMatchingGameState createState() => _ASLMatchingGameState();
}

class _ASLMatchingGameState extends State<ASLMatchingGame> {
  final Map<String, bool> score = {};
  final Map<String, String> letterData = {
    'A': 'assets/sign_pics/A.PNG',
    'B': 'assets/sign_pics/B.PNG',
    'C': 'assets/sign_pics/C.PNG',
    // 'D': 'assets/sign_pics/D.PNG',
    // 'E': 'assets/sign_pics/E.PNG',
    // 'F': 'assets/sign_pics/F.PNG',
    // 'G': 'assets/sign_pics/G.PNG',
    // 'H': 'assets/sign_pics/H.PNG',
    // 'I': 'assets/sign_pics/I.PNG',
    // 'J': 'assets/sign_pics/J.PNG',
    // 'K': 'assets/sign_pics/K.PNG',
    // 'L': 'assets/sign_pics/L.PNG',
    // 'M': 'assets/sign_pics/M.PNG',
    // 'N': 'assets/sign_pics/N.PNG',
    // 'O': 'assets/sign_pics/O.PNG',
    // 'P': 'assets/sign_pics/P.PNG',
    // 'Q': 'assets/sign_pics/Q.PNG',
    // 'R': 'assets/sign_pics/R.PNG',
    // 'S': 'assets/sign_pics/S.PNG',
    // 'T': 'assets/sign_pics/T.PNG',
    // 'U': 'assets/sign_pics/U.PNG',
    // 'V': 'assets/sign_pics/V.PNG',
    // 'W': 'assets/sign_pics/W.PNG',
    // 'X': 'assets/sign_pics/X.PNG',
    // 'Y': 'assets/sign_pics/Y.PNG',
    // 'Z': 'assets/sign_pics/Z.PNG'
  };

  int seed = 0;
  int currentPageIndex = 0;
  final int itemsPerPage = 3;
  late PageController _pageController;
  late List<String> previousPageLetters; 

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    previousPageLetters = [];
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final int pageCount = (letterData.length / itemsPerPage).ceil();
    final List<List<String>> pages = List.generate(
      pageCount,
      (index) => letterData.keys.skip(index * itemsPerPage).take(itemsPerPage).toList(),
    );
 return Scaffold(
    appBar: AppBar(
      iconTheme: IconThemeData(
        color: Colors.white, // Change the color of the back arrow here
      ),
      title: Text(
        'Score: ${score.length} / ${letterData.length}',
        style: TextStyle(
          color: Colors.white,
          fontSize: 30.0,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.purple[800],
    ),
    body: Container(
      color: Colors.pink[100], // Replace this with your preferred background color
      child: Column(
        children: [
          SizedBox(height: 20), // Add spacing between the app bar and text
          Text(
            'Drag and Drop to Match',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.pink[500],
            ),
          ),
          Expanded(
            child: Center(
              child: Stack(
                children: [
                  PageView.builder(
                    controller: _pageController,
                    itemCount: pageCount,
                    onPageChanged: (int index) {
                      setState(() {
                        currentPageIndex = index;
                      });
                    },
                    itemBuilder: (BuildContext context, int index) {
                      return _buildPage(pages[index]);
                    },
                  ),
                  _buildNextPageButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

  Widget _buildPage(List<String> pageLetters) {
  return SingleChildScrollView(
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: pageLetters.map((letter) {
              return Draggable<String>(
                data: letter,
                child: ASLImage(
                  imagePath: score[letter] == true ? 'assets/AR.jpg' : letterData[letter]!,
                ),
                feedback: ASLImage(imagePath: letterData[letter]!),
                childWhenDragging: ASLImage(imagePath: 'assets/practice.png'),
              );
            }).toList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: pageLetters.map((letter) {
              return _buildDragTarget(letter);
            }).toList()
              ..shuffle(Random(seed)),
          ),
        ],
      ),
    ),
  );
}

Widget _buildDragTarget(String letter) {
  return DragTarget<String>(
    builder: (BuildContext context, List<String?> incoming, List<dynamic> rejected) {
      if (score.containsKey(letter) && score[letter] == true) {
        return Container(
          color: Colors.pink[500],
          child: Center(
            child: Text(
              'Correct!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          alignment: Alignment.center,
          height: 100,
          width: 100,
        );
      } else {
        return Container(
          color: Colors.purple[400],
          height: 100,
          width: 100,
          child: Center(
            child: Text(
              letter,
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          alignment: Alignment.center,
        );
      }
    },
    onWillAccept: (data) => data == letter,
    onAccept: (data) {
      setState(() {
        score[letter] = true;
        _checkAndNavigate();
      });
    },
    onLeave: (data) {},
  );
}


  void _checkAndNavigate() {
    final int pageCount = (letterData.length / itemsPerPage).ceil();
    final List<String> currentPage = letterData.keys.skip(currentPageIndex * itemsPerPage).take(itemsPerPage).toList();
    final bool isCurrentPageCompleted = currentPage.every((letter) => score.containsKey(letter));
     previousPageLetters.addAll(currentPage);
     print(previousPageLetters);

    if (isCurrentPageCompleted && currentPageIndex < pageCount - 1) {
      setState(() {
        currentPageIndex++;
      });
    } else if (isCurrentPageCompleted && currentPageIndex == pageCount - 1) {

       Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CongratulationsScreen(),
      ),
    );
    }
  }

  Widget _buildNextPageButton() {
    final int pageCount = (letterData.length / itemsPerPage).ceil();

    final List<String> currentPage = letterData.keys.skip(currentPageIndex * itemsPerPage).take(itemsPerPage).toList();
    final bool isPreviousPagesCompleted = previousPageLetters.every((letter) => score.containsKey(letter) && score[letter] == true);

    
    if (isPreviousPagesCompleted) {
      return Positioned(
        bottom: 20,
        right: 20,
        child: ElevatedButton(
          onPressed: () {
            _pageController.nextPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
          },
          child: Text('Go to Next Page'),
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }
}

class ASLImage extends StatelessWidget {
  final String imagePath;

  ASLImage({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        alignment: Alignment.center,
        height: 400,
        padding: EdgeInsets.all(1),
        child: Image.asset(
          imagePath,
          height: 150,
          width: 100,
        ),
      ),
    );
  }
}

class CongratulationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'You did it!',
          style: TextStyle(
            color: Colors.yellow,
            fontSize: 30.0,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.star,
              size: 100,
              color: Colors.yellow,
            ),
            SizedBox(height: 20),
            Text(
              'CONGRATULATIONS!!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'All pages completed!',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => GameScreen(),
                  ),
                );
              },
              child: Text('Go back to practice'),
            ),
          ],
        ),
      ),
    );
  }
}
