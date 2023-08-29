import 'dart:async';

import 'package:attendance/model/firebase_auth.dart';
import 'package:attendance/view/home_screen.dart';
import 'package:flutter/material.dart';
import '../custom_icons/my_flutter_app_icons.dart';

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

class EmailTextField extends StatelessWidget {
  final TextEditingController emailController;
  const EmailTextField({
    Key? key,
    required this.emailController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        controller: emailController,
        decoration: const InputDecoration(
            prefixIcon: Icon(Icons.email_outlined),
            hintText: "example@gmail.com",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            )),
      ),
    );
  }
}

class PasswordTextField extends StatefulWidget {
  final TextEditingController passwordController;
  const PasswordTextField({
    Key? key,
    required this.passwordController,
  }) : super(key: key);

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  @override
  void dispose() {
    widget.passwordController.dispose();
    super.dispose();
  }

  bool toggle = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        controller: widget.passwordController,
        obscureText: toggle,
        decoration: InputDecoration(
          prefixIcon: GestureDetector(
            child: Icon(
              (toggle) ? (MyFlutterApp.eye_slash) : (MyFlutterApp.eye),
              size: 20,
            ),
            onTap: () {
              setState(() {
                toggle = !toggle;
              });
            },
          ),
          hintText: "password",
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
      ),
    );
  }
}
