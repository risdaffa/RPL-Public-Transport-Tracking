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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyBZ6439AZ2OcwcJSlRSgXdRtk9Dl35Q3oY',
    appId: '1:421282917312:web:4110d59fc1a4b3747b3625',
    messagingSenderId: '421282917312',
    projectId: 'public-transport-b89df',
    authDomain: 'public-transport-b89df.firebaseapp.com',
    storageBucket: 'public-transport-b89df.appspot.com',
    measurementId: 'G-4V8DRPS11X',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDQA3Pj3RudjgeGZtt_itcgXOAcoCWu3PA',
    appId: '1:421282917312:android:07f109e1e4dedef07b3625',
    messagingSenderId: '421282917312',
    projectId: 'public-transport-b89df',
    storageBucket: 'public-transport-b89df.appspot.com',
  );
}
