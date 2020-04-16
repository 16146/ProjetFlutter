import 'package:flutter/material.dart';
import 'package:grades/models/user.dart';
import 'package:grades/screens/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:grades/services/authService.dart';

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
