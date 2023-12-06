import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'game.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  final ImagePicker _picker = ImagePicker();

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
    final PermissionStatus permissionStatus = await Permission.camera.request();
    if (permissionStatus.isGranted) {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        // Call your query function passing the image file path
        try {
          print("Trying to query API with image: ${image.path}");
          final result = await query(image.path);
          print("API Result: $result");
          // Navigate to the result screen and pass the result
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ResultScreen(result: result),
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
            SizedBox(height: 30), // Add space between the button and instructions
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
                '- Get your result!\n\n'
                '**This technology uses an image recognition model to recognize your signs and will display the top 5 matches!**',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),),
          ],
        ),
      ),
    );
  }
}
class ResultScreen extends StatelessWidget {
  final List<dynamic> result;

  ResultScreen({required this.result});

  @override
  Widget build(BuildContext context) {
    // Extract the top 5 labels from the result list
    List<String> top5Labels = result
        .sublist(0, result.length > 5 ? 5 : result.length)
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
                color: Colors.purple[100], // Set the background color
                borderRadius: BorderRadius.circular(10.0), // Optional: Add border radius
              ),
              child: Text(
                'Top 5 Results: $top5Labels', // Display top 5 results here
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
              'These results display what your sign looks like.\n'
              'Not what your looking for? Try again!', // Add your additional text
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                 fontWeight: FontWeight.bold,
                color: Colors.yellow[800],
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
