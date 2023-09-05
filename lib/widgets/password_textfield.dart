import 'package:flutter/material.dart';

import '../custom_icons/my_flutter_app_icons.dart';

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
