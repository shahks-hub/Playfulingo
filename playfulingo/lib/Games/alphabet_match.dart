import 'package:flutter/material.dart';
import 'dart:math';

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
    'D': 'assets/sign_pics/D.PNG',
    'E': 'assets/sign_pics/E.PNG',
    'F': 'assets/sign_pics/F.PNG',
    'G': 'assets/sign_pics/G.PNG',
    'H': 'assets/sign_pics/H.PNG',
    'I': 'assets/sign_pics/I.PNG',
    'J': 'assets/sign_pics/J.PNG',
    'K': 'assets/sign_pics/K.PNG',
    'L': 'assets/sign_pics/L.PNG',
    'M': 'assets/sign_pics/M.PNG',
    'N': 'assets/sign_pics/N.PNG',
    'O': 'assets/sign_pics/O.PNG',
    'P': 'assets/sign_pics/P.PNG',
    'Q': 'assets/sign_pics/Q.PNG',
    'R': 'assets/sign_pics/R.PNG',
    'S': 'assets/sign_pics/S.PNG',
    'T': 'assets/sign_pics/T.PNG',
    'U': 'assets/sign_pics/U.PNG',
    'V': 'assets/sign_pics/V.PNG',
    'W': 'assets/sign_pics/W.PNG',
    'X': 'assets/sign_pics/X.PNG',
    'Y': 'assets/sign_pics/Y.PNG',
    'Z': 'assets/sign_pics/Z.PNG'
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
        title: Text('Score: ${score.length} / ${letterData.length}'),
        backgroundColor: Colors.green,
      ),
      body: Stack(
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
    );
  }

  Widget _buildPage(List<String> pageLetters) {
    return SingleChildScrollView(
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
    );
  }

  Widget _buildDragTarget(String letter) {
    return DragTarget<String>(
      builder: (BuildContext context, List<String?> incoming, List<dynamic> rejected) {
        if (score.containsKey(letter) && score[letter] == true) {
          return Container(
            color: Colors.white,
            child: Text('Correct!'),
            alignment: Alignment.center,
            height: 80,
            width: 100,
          );
        } else {
          return Container(
            color: Colors.blueGrey,
            height: 80,
            width: 100,
            child: Text(letter),
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

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('All pages completed!'),
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
        height: 50,
        padding: EdgeInsets.all(10),
        child: Image.asset(
          imagePath,
          height: 100,
          width: 100,
        ),
      ),
    );
  }
}
