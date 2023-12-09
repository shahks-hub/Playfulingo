// import 'dart:io';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:tflite/tflite.dart';
// import 'package:camera/camera.dart';
// //import 'package:image/image.dart' as img;
// //import 'package:tflite_flutter/tflite_flutter.dart' as tfl;

// class GestureScreen extends StatefulWidget {
//   const GestureScreen({Key? key}) : super(key: key);

//   @override
//   _GestureScreenState createState() => _GestureScreenState();
// }

// // make recognition class
// class _GestureScreenState extends State<GestureScreen> {
//   // holds 3 keys, confidence, index and label
//   List<dynamic> _recognitions = [];
//   bool _modelLoaded = false;
//   String _pickedImagePath = '';
//   late CameraController _cameraController;
//   bool _isCameraActive = false;

//   // gives resources and makes sure model is loaded only once
//   @override
//   void initState() {
//     super.initState();
//     loadModel();
//     setupCamera();
//   }

//   // loads the model for detection
//   Future<void> loadModel() async {
//     // final interpreter = await tfl.Interpreter.fromAsset('assets/model.tflite');

//     try {
//       await Tflite.loadModel(
//         model: 'assets/model.tflite',
//         labels: 'assets/labels.txt',
//       );
//       setState(() {
//         _modelLoaded = true;
//       });
//     } catch (e) {
//       if (kDebugMode) {
//         print('Error loading model: $e');
//       }
//     }
//   }

//   /* 
//   Sets up the camera for stream
//   */
//   Future<void> setupCamera() async {
//     final cameras = await availableCameras();
//     _cameraController = CameraController(cameras[0], ResolutionPreset.medium);
//     await _cameraController.initialize();
//   }

//   /*
//   Generates frames for gesture detection
//   -> starts streaming from the camera that is set up
//    */
//   Future<void> startCameraStream() async {
//     if (!_isCameraActive) {
//       await _cameraController.startImageStream((CameraImage image) {
//         if (_modelLoaded) {
//           runModelOnFrame(image);
//         }
//       });
//       setState(() {
//         _isCameraActive = true;
//       });
//     }
//   }

// /*
// Stops the camera stream when user indicates

//  */
//   void stopCameraStream() {
//     if (_isCameraActive) {
//       _cameraController.stopImageStream();
//       setState(() {
//         _isCameraActive = false;
//       });
//     }
//   }

//   /*
//   Allows user to grab image (take a picture or drive)
//   -> option to choose camera or gallery for source
//    */
//   Future<void> _pickImage() async {
//     // Show a dialog to let the user choose between camera and gallery.
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text("Select Image Source"),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                   _getImage(ImageSource.camera);
//                 },
//                 child: const Text("Camera"),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                   _getImage(ImageSource.gallery);
//                 },
//                 child: const Text("Gallery"),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

// /*
// Gets the image as per user choice, camera or gallery
// -> gets imagepath to be used for our model 
//  */
//   Future<void> _getImage(ImageSource source) async {
//     final imagePicker = ImagePicker();
//     final pickedImage = await imagePicker.pickImage(source: source);

//     if (pickedImage != null) {
//       setState(() {
//         _pickedImagePath = pickedImage.path;
//       });
//       runModelOnImage(pickedImage.path);
//     }
//   }

// /*
//  Runs inference on images from camera stream
//  -> in use whenever user starts their camera
//  */
//   Future<void> runModelOnFrame(CameraImage image) async {
//     try {
//       var recognitions = await Tflite.runModelOnFrame(
//         bytesList: image.planes.map((e) => e.bytes).toList(),
//         imageHeight: image.height,
//         imageWidth: image.width,
//         imageMean: 127.5,
//         imageStd: 127.5,
//         numResults: 1,
//         rotation: 90,
//         threshold: 0.4,
//       );

//       setState(() {
//         _recognitions = recognitions ?? [];
//       });
//     } catch (e) {
//       if (kDebugMode) {
//         print('Error running model: $e');
//       }
//     }
//   }

// /*
// Runs inference on image that is specified by image path
// -> gets the key values
//  */
//   Future<void> runModelOnImage(String imagePath) async {
//     try {
//       // stores back all the key values for all possible labels
//       var recognitions = await Tflite.runModelOnImage(
//         path: imagePath,
//       );

//       setState(() {
//         // feeds the original global list to be used for printing
//         _recognitions = recognitions ?? [];
//       });
//     } catch (e) {
//       if (kDebugMode) {
//         print('Error running model: $e');
//       }
//     }
//   }

//   // important for releasing resources when screen changes or app closes
//   @override
//   void dispose() {
//     _cameraController.dispose();
//     Tflite.close();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('TFLite Gesture Detection'),
//         ),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               if (_recognitions.isNotEmpty && _modelLoaded)
//                 Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     children: [
//                       // conditions for displaying the correct aspect
//                       if (_isCameraActive)
//                         Container(
//                           width: double
//                               .infinity, // Take up the entire width of the screen
//                           height: double
//                               .infinity, // Take up the entire height of the screen
//                           child: _isCameraActive
//                               ? AspectRatio(
//                                   aspectRatio:
//                                       _cameraController.value.aspectRatio,
//                                   child: CameraPreview(_cameraController),
//                                 )
//                               : SizedBox(),
//                         ),
//                       if (!_isCameraActive && _pickedImagePath.isNotEmpty)
//                         Image.file(File(_pickedImagePath), height: 200),
//                       const SizedBox(height: 16),
//                       Text(
//                         'Detected Sign: ${_recognitions[0]['label']}', // index 0 means the highest confidence label
//                         style: const TextStyle(
//                             fontSize: 20, fontWeight: FontWeight.bold),
//                         textAlign: TextAlign.center,
//                       ),
//                       const SizedBox(height: 16),
//                       Text(
//                         'Confidence Level: ${(_recognitions[0]['confidence'] * 100).toStringAsFixed(2)}%',
//                         style: const TextStyle(fontSize: 16),
//                         textAlign: TextAlign.center,
//                       ),
//                       const SizedBox(height: 16),
//                       LinearProgressIndicator(
//                         value: _recognitions[0]['confidence'],
//                         minHeight: 10,
//                         backgroundColor: Colors.grey[300]!,
//                         valueColor:
//                             const AlwaysStoppedAnimation<Color>(Colors.blue),
//                       ),
//                     ],
//                   ),
//                 ),
//               ElevatedButton(
//                 onPressed: () {
//                   // Clear previous data
//                   setState(() {
//                     _pickedImagePath = '';
//                     _recognitions = [];
//                   });
//                   _pickImage();
//                 },
//                 child: const Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Icon(Icons.image),
//                     SizedBox(width: 8),
//                     Text('Try Gesture Detection!'),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 16),
//               ElevatedButton(
//                 onPressed: () {
//                   // Clear previous data
//                   setState(() {
//                     _pickedImagePath = '';
//                     _recognitions = [];
//                   });
//                   _isCameraActive ? stopCameraStream() : startCameraStream();
//                 },
//                 child: Text(_isCameraActive ? 'Stop Camera' : 'Start Camera'),
//               ),
//               if (!_modelLoaded) const SizedBox(height: 16),
//               if (!_modelLoaded) // shows loading status indicating there is a problem
//                 const Center(
//                   child: CircularProgressIndicator(),
//                 ),
//             ],
//           ),
//         ));
//   }
// }
