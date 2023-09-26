// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyD7NPQAnWpjXiXMIw0Q1qOQ8B9OzCwVjyw',
    appId: '1:1010049478620:web:b945f0defc80042af62919',
    messagingSenderId: '1010049478620',
    projectId: 'playfulingo',
    authDomain: 'playfulingo.firebaseapp.com',
    databaseURL: 'https://playfulingo-default-rtdb.firebaseio.com',
    storageBucket: 'playfulingo.appspot.com',
    measurementId: 'G-RZCD3MK9CY',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAjuyrQKy8Dg7aMSFjTTK0dZuE--3VO8SA',
    appId: '1:1010049478620:android:8109fb21d758f910f62919',
    messagingSenderId: '1010049478620',
    projectId: 'playfulingo',
    databaseURL: 'https://playfulingo-default-rtdb.firebaseio.com',
    storageBucket: 'playfulingo.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDpVtnUFu7eZU-Hcf7hwSqzTqZZe0rkWhI',
    appId: '1:1010049478620:ios:93d5c6afa07234bbf62919',
    messagingSenderId: '1010049478620',
    projectId: 'playfulingo',
    databaseURL: 'https://playfulingo-default-rtdb.firebaseio.com',
    storageBucket: 'playfulingo.appspot.com',
    iosBundleId: 'com.example.playfulingo',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDpVtnUFu7eZU-Hcf7hwSqzTqZZe0rkWhI',
    appId: '1:1010049478620:ios:012e8dc127ed662ef62919',
    messagingSenderId: '1010049478620',
    projectId: 'playfulingo',
    databaseURL: 'https://playfulingo-default-rtdb.firebaseio.com',
    storageBucket: 'playfulingo.appspot.com',
    iosBundleId: 'com.example.playfulingo.RunnerTests',
  );
}
