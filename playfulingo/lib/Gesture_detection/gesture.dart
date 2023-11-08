import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class GestureScreen extends StatefulWidget {
  const GestureScreen({Key? key}) : super(key: key);

  @override
  _GestureScreenState createState() => _GestureScreenState();
}

// make recognition class
class _GestureScreenState extends State<GestureScreen> {
  // holds 3 keys, confidence, index and label
  List<dynamic> _recognitions = [];
  bool _modelLoaded = false;
  String _pickedImagePath = '';

  // gives resources and makes sure model is loaded only once
  @override
  void initState() {
    super.initState();
    loadModel();
  }

  // loads the model for detection
  Future<void> loadModel() async {
    try {
      await Tflite.loadModel(
        model: 'assets/model.tflite',
        labels: 'assets/labels.txt',
      );
      setState(() {
        _modelLoaded = true;
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error loading model: $e');
      }
    }
  }

  // allows user to grab images from gallery (photos or drive)
  Future<void> _pickImage() async {
    // Show a dialog to let the user choose between camera and gallery.
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Select Image Source"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _getImage(ImageSource.camera);
                },
                child: const Text("Camera"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _getImage(ImageSource.gallery);
                },
                child: Text("Gallery"),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _getImage(ImageSource source) async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: source);

    if (pickedImage != null) {
      setState(() {
        _pickedImagePath = pickedImage.path;
      });
      runModelOnImage(pickedImage.path);
    }
  }

  Future<void> runModelOnImage(String imagePath) async {
    try {
      // stores back all the key values for all possible labels
      var recognitions = await Tflite.runModelOnImage(
        path: imagePath,
      );

      setState(() {
        // feeds the original global list to be used for printing
        _recognitions = recognitions ?? [];
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error running model: $e');
      }
    }
  }

  // important for releasing resources when screen changes or app closes
  @override
  void dispose() {
    Tflite.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('TFLite Gesture Detection'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (_recognitions.isNotEmpty && _modelLoaded)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Image.file(File(_pickedImagePath), height: 200),
                      Text(
                        'Detected Sign: ${_recognitions[0]['label']}', // index 0 means the highest confidence label
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Confidence Level: ${(_recognitions[0]['confidence'] * 100).toStringAsFixed(2)}%',
                        style: const TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      LinearProgressIndicator(
                        value: _recognitions[0]['confidence'],
                        minHeight: 10,
                        backgroundColor: Colors.grey[300]!,
                        valueColor:
                            const AlwaysStoppedAnimation<Color>(Colors.blue),
                      ),
                    ],
                  ),
                ),
              ElevatedButton(
                onPressed: _pickImage,
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.image),
                    SizedBox(width: 8),
                    Text('Try Gesture Detection!'),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              if (!_modelLoaded) const SizedBox(height: 16),
              if (!_modelLoaded) // shows loading status indicating there is a problem
                const Center(
                  child: CircularProgressIndicator(),
                ),
            ],
          ),
        ));
  }
}
