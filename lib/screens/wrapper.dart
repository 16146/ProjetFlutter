import 'package:flutter/material.dart';
import 'package:grades/screens/authenticate/authenticate.dart';
import 'package:grades/screens/homePage.dart';
import 'package:grades/models/user.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    //return either Home or Authenticate widget
    print(user);
    if (user == null) {
      return Authenticate();
    } else {
      return HomePage();
    }
  }
}