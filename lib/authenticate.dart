import 'register.dart';
import 'sign_in.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  
  bool showConnexion = true;
  void toggleView() {
    setState(() => showConnexion = !showConnexion);
  }
  @override
  Widget build(BuildContext context) {
    if (showConnexion) {
      return SignIn(toggleView: toggleView);
    } else {
      return Register(toggleView: toggleView);
    }
  }
}