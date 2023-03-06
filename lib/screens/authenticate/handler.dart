import 'Login.dart';
import 'Register.dart';
import 'package:flutter/material.dart';

class Handler extends StatefulWidget {
  @override
  State<Handler> createState() => _HandlerState();
}

class _HandlerState extends State<Handler> {
  bool showSignin = true;

  void register() {
    setState(() {
      showSignin = !showSignin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignin) {
      return LoginScreen(register: register);
    } else {
      return RegisterScreen(register: register);
    }
  }
}
