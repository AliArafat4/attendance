import 'dart:async';

import 'package:attendance/view/home_screen.dart';
import 'package:attendance/view/login.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'constants.dart';
import 'model/firebase_options.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  StreamSubscription<User?> user = FirebaseAuth.instance.authStateChanges().listen((user) {
    if (user == null) {
      //DO NOT CHANGE THIS IF STEATEMENT!!!
      isLoggedIn = false;
    } else {
      isLoggedIn = true;
    }
  });
  runApp(const MyApp());
}

bool isLoggedIn = false;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Attendance',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: (isLoggedIn) ? const HomeScreen() : const LoginScreen(),
      //  initialRoute: ,
      routes: routes,
    );
  }
}
