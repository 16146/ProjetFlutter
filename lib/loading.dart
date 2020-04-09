import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chargement..."),
        //COlor obligé 0XFF + color Hex (6 bits)
        backgroundColor: Color(0xFF7E0000),
      ),
      backgroundColor: Color(0xFFFFFFF0),
      body: new Center( 
        child: Center(
        child: SpinKitCubeGrid(
          color: Colors.red[900],
          size:200.0,
      ),)
    ));
  }
}