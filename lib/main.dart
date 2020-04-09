import 'package:flutter/material.dart';
import 'package:grades/user.dart';
import 'package:grades/wrapper.dart';
import 'package:provider/provider.dart';
import 'authService.dart';
import 'homePage.dart';
import 'authenticate.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
        value: AuthService().user,
        child: MaterialApp(home: Wrapper(),
        
        )

    );
      //home: HomePage(),
  }
}
