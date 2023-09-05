import 'dart:async';

import 'package:attendance/model/firebase_auth.dart';
import 'package:attendance/view/home_screen.dart';
import 'package:flutter/material.dart';
import '../widgets/email_textfield.dart';
import '../widgets/password_textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  bool flag = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            EmailTextField(emailController: _emailController),
            PasswordTextField(passwordController: _passwordController),
            (flag) ? const SizedBox() : const LinearProgressIndicator(),
          ],
        ),
      ),
      floatingActionButton: ElevatedButton(
          onPressed: () async {
            var user = await login(_emailController.text, _passwordController.text);
            if (!user.toString().contains("False")) {
              if (mounted) {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => const HomeScreen()));
              }
            } else {
              setState(() {
                flag = false;
                Future.delayed(const Duration(seconds: 2), () {
                  flag = true;
                  setState(() {});
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      behavior: SnackBarBehavior.floating,
                      content: Text('Check your Email & Password')));
                });
              });
            }
          },
          child: const Text("login")),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
