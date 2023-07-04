import 'package:attendance/view/home_screen.dart';
import 'package:attendance/view/selectFile_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [],
        ),
      ),
      floatingActionButton: ElevatedButton(
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => const HomeScreen()));
          },
          child: const Text("login")),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
