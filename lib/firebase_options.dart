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
        return web;
      case TargetPlatform.linux:
        return web;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDoOsABtgrayoFOQSOw6TL83fs_bJxvJp8',
    appId: '1:587656046911:web:e02d8dc4c98c66937e4b8a',
    messagingSenderId: '587656046911',
    projectId: 'memo-app-e9084',
    authDomain: 'memo-app-e9084.firebaseapp.com',
    storageBucket: 'memo-app-e9084.firebasestorage.app',
    measurementId: 'G-R0ZBH41BLF',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCtKgK4KLj5MOS0peuVsh5SW6Wx9n4vzb4',
    appId: '1:587656046911:android:0b913e2e934911ab7e4b8a',
    messagingSenderId: '587656046911',
    projectId: 'memo-app-e9084',
    storageBucket: r'memo-app-e9084.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB63SX92cPdWalx98ZaQ7usCfyW6CPz50M',
    appId: '1:587656046911:ios:bd07486c611b9d597e4b8a',
    messagingSenderId: '587656046911',
    projectId: 'memo-app-e9084',
    storageBucket: 'memo-app-e9084.firebasestorage.app',
    iosBundleId: 'com.example.memoApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB63SX92cPdWalx98ZaQ7usCfyW6CPz50M',
    appId: '1:587656046911:ios:9092e290b8031ebb7e4b8a',
    messagingSenderId: '587656046911',
    projectId: 'memo-app-e9084',
    storageBucket: 'memo-app-e9084.firebasestorage.app',
    iosBundleId: 'com.example.memoApp.RunnerTests',
  );
}