import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

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

    final apiUrl = Uri.parse(
        "https://api-inference.huggingface.co/models/dima806/asl_alphabet_image_detection");
    print("Function 'query' - API URL: $apiUrl");
  
    try {
      print("Function 'query' - making POST request");
      final response = await http.post(
        apiUrl,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer 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',
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
        title: Text('Camera Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _getImageFromCamera,
              child: Text('Take Picture'),
            ),
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Result Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Results: $result'), // Display results here as needed
          ],
        ),
      ),
    );
  }
}
