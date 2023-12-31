import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'game.dart';
import 'package:playfulingo/Firebase/firebase_functions.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  final ImagePicker _picker = ImagePicker();
  int score = 0; // Initialize score
  @override
  void initState() {
    super.initState();
    fetchAndUpdateCurrentScore();
  }

  Future<void> fetchAndUpdateCurrentScore() async {
    try {
      score = await getCurrentHighestScore('snap_recog');
      setState(() {});
    } catch (e) {
      print('Error fetching and updating score: $e');
    }
  }

  Future<List<dynamic>> query(String filename) async {
    print("Function 'query' called");

    final File imageFile = File(filename);
    print('File located at: ${imageFile.path}');
    final imageBytes = await imageFile.readAsBytes();
    final String apiToken = dotenv.env['API_TOKEN'] ?? '';

    final apiUrl = Uri.parse(
        "https://api-inference.huggingface.co/models/dima806/asl_alphabet_image_detection");
    print("Function 'query' - API URL: $apiUrl");

    try {
      print("Function 'query' - making POST request");
      final response = await http.post(
        apiUrl,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $apiToken',
          HttpHeaders.contentTypeHeader: "application/json",
        },
        body: imageBytes,
      );

      if (response.statusCode == 200) {
        // Parse the response
        final List<dynamic> result = json.decode(response.body);
        print("Function 'query' - API response: $result");
        return result;
      } else {
        throw Exception('Failed to query the API');
      }
    } catch (e) {
      throw Exception('Failed to perform API call: $e');
    }
  }

  Future<void> _getImageFromCamera() async {
    try {
      final PermissionStatus permissionStatus =
          await Permission.camera.request();
      if (permissionStatus.isGranted) {
        final XFile? image =
            await _picker.pickImage(source: ImageSource.camera);
        if (image != null) {
          try {
            print("Trying to query API with image: ${image.path}");
            final result = await query(image.path);
            print("API Result: $result");
            setState(() {
              score++; // Increment score on successful image capture
            });
            await updateGameScore('snap_recog', score);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ResultScreen(result: result, score: score),
              ),
            );
          } catch (e) {
            print('Error related to API query: $e');
          }
        } else {
          print('No image selected');
        }
      } else {
        print('Camera permission denied');
      }
    } catch (e) {
      print('Error while picking image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Camera Screen',
          style: TextStyle(
            color: Colors.yellow[500],
            fontSize: 30.0,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.pink[200],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _getImageFromCamera,
              child: Text(
                'Click here to take a picture',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 30),
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.purple[100],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                'Use this module to test your skills! \nInstructions:\n'
                '- Click the button above to take a picture using the camera on your phone\n'
                '- Sign an alphabet and click a picture of your hand\n'
                '- Submit the photo for review\n'
                '- Get your result! and you get points just for trying!\n\n'
                '**This technology uses an image recognition model to recognize your signs and will display the top 5 matches!**',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 35),
            Text(
              'Current Score: $score',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.pink[500],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ResultScreen extends StatefulWidget {
  final List<dynamic> result;
  final int score;

  ResultScreen({required this.result, required this.score});

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    List<String> top5Labels = widget.result
        .sublist(0, widget.result.length > 5 ? 5 : widget.result.length)
        .map((item) => item['label'] as String)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Result Screen',
          style: TextStyle(
            color: Colors.yellow[500],
            fontSize: 30.0,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.pink[200],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(12.0),
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                color: Colors.purple[100],
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(
                'Top 5 Results: $top5Labels',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple[800],
                ),
              ),
            ),
            SizedBox(height: 35),
            Text(
              'Updated Score: ${widget.score}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.pink[500],
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
