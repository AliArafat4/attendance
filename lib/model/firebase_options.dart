import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBRR_ZGFlF9DoNkw-z6cuV0WDFKJmNRyok',
    appId: '1:293790731526:android:0f8da073402989066de287',
    messagingSenderId: '293790731526',
    projectId: 'attendance-e1db3',
    storageBucket: 'attendance-e1db3.appspot.com',
  );

  //TODO: configure/fix
  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA6ihDOisNiME3Kurcg9mJqmni7K09PbLU',
    appId: '1:138777932173:ios:2d5717f12e5970f4fc8dc4',
    messagingSenderId: '293790731526',
    projectId: 'wemeet-8a408',
    storageBucket: 'attendance-e1db3.appspot.com',
    iosClientId:
        '138777932173-vmc6b81mp8nghf7ffilu902a03834vb9.apps.googleusercontent.com',
    iosBundleId: 'com.example.wemeetMobile',
  );
}
