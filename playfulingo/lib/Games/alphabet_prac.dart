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
  String? base64_image; 
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

 

 Future<List<dynamic>> queryOpenAI(String imageUrl) async {
  final apiUrl = Uri.parse("https://api.openai.com/v1/chat/completions");
  
  final api_key = dotenv.env['OPENAI_API_KEY'];
  
  final headers = {
    "Content-Type": "application/json",
    "Authorization": "Bearer $api_key",
  };
    
  final payload = {
    "model": "gpt-4-vision-preview",
    "messages": [
      {
        "role": "user",
        "content": [
          {
            "type": "text",
            "text": "What’s in this image?",
          },
          {
            "type": "image_url",
            "image_url": {"url": imageUrl},
          },
        ],
      }
    ],
    "max_tokens": 300,
  };
  //  print("headers: $headers , body is: $payload");
  final response = await http.post(apiUrl, headers: headers, body: json.encode(payload));

  if (response.statusCode == 200) {
    final List<dynamic> result = json.decode(response.body);
    return result;
  } else {
    throw Exception('Failed to query the OpenAI API');
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
            final imageUrl = "https://upload.wikimedia.org/wikipedia/commons/thumb/d/dd/Gfp-wisconsin-madison-the-nature-boardwalk.jpg/2560px-Gfp-wisconsin-madison-the-nature-boardwalk.jpg";
            // final imageUrl = "data:image/jpeg;base64,${base64_image}";
            final result = await queryOpenAI(imageUrl);
        
            
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
              child: Column(
                children: [
                  Text(
                    'Results:',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple[800],
                    ),
                  ),
                  SizedBox(height: 15),
                  // Display the entire result
                  for (var message in widget.result)
                    Text(
                      '${message['role']}: ${message['content'][0]['text']}',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                      ),
                    ),
                ],
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
