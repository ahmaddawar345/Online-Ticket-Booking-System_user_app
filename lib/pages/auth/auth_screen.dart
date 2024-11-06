import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';
import 'signup_screen.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogIn = true;
  void toggleSignInSignUp() {
    setState(() {
      isLogIn = !isLogIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLogIn
        ? LoginScreen(toggleBetweenLoginSignUp: toggleSignInSignUp)
        : SignupScreen(toggleBetweenLoginSignUp: toggleSignInSignUp);
  }
}
