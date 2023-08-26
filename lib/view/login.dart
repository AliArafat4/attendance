import 'package:attendance/model/firebase.dart';
import 'package:attendance/view/home_screen.dart';
import 'package:flutter/material.dart';
import '../custom_icons/my_flutter_app_icons.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _passwordController = TextEditingController();
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email_outlined),
                    hintText: "example@gmail.com",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    )),
              ),
            ),
            PasswordTextField(passwordController: _passwordController),
          ],
        ),
      ),
      floatingActionButton: ElevatedButton(
          onPressed: () {
            signup("name", "email", _passwordController.text);
            // Navigator.pushReplacement(
            //     context, MaterialPageRoute(builder: (context) => const HomeScreen()));
          },
          child: const Text("login")),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
          hintText: "",
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        onChanged: (val) {
          widget.passwordController.text = val;
        },
      ),
    );
  }
}
