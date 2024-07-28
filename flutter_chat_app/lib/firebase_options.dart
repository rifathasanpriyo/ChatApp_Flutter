// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyBS13OFF2YhtTpsiuOZXu1hPeV_5gxJrpI',
    appId: '1:981454982825:web:cadc3a30b3639491e0a3b8',
    messagingSenderId: '981454982825',
    projectId: 'chatapp-ci-be5d3',
    authDomain: 'chatapp-ci-be5d3.firebaseapp.com',
    storageBucket: 'chatapp-ci-be5d3.appspot.com',
    measurementId: 'G-C5JHER012F',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBq6K7xbK_9auA0Fe6hEURDuZBXNv94NGU',
    appId: '1:981454982825:android:c4deb01c2d56a6b0e0a3b8',
    messagingSenderId: '981454982825',
    projectId: 'chatapp-ci-be5d3',
    storageBucket: 'chatapp-ci-be5d3.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDyGnPZMRn9UfoYKQDik-0N9izqqs0t1ck',
    appId: '1:981454982825:ios:1ef1f07dfa8c6b34e0a3b8',
    messagingSenderId: '981454982825',
    projectId: 'chatapp-ci-be5d3',
    storageBucket: 'chatapp-ci-be5d3.appspot.com',
    iosBundleId: 'com.example.flutterApplication1',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDyGnPZMRn9UfoYKQDik-0N9izqqs0t1ck',
    appId: '1:981454982825:ios:1ef1f07dfa8c6b34e0a3b8',
    messagingSenderId: '981454982825',
    projectId: 'chatapp-ci-be5d3',
    storageBucket: 'chatapp-ci-be5d3.appspot.com',
    iosBundleId: 'com.example.flutterApplication1',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBS13OFF2YhtTpsiuOZXu1hPeV_5gxJrpI',
    appId: '1:981454982825:web:da53ff70874c7355e0a3b8',
    messagingSenderId: '981454982825',
    projectId: 'chatapp-ci-be5d3',
    authDomain: 'chatapp-ci-be5d3.firebaseapp.com',
    storageBucket: 'chatapp-ci-be5d3.appspot.com',
    measurementId: 'G-E6YJ9V5DVC',
  );
}
