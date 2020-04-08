import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'studentListPage.dart';
import 'avisList.dart';
import 'testListPage.dart';

class HomePage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFF0),
      appBar: AppBar(
        title: Text("Ecole Sud d'Arthedain"),
        //COlor obligé 0XFF + color Hex (6 bits)
        backgroundColor: Color(0xFF7E0000),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          AspectRatio(
            aspectRatio: 1,
            child: FlareActor(
              "assets/Student.flr",
              alignment: Alignment.center,
              fit: BoxFit.contain,
              animation: 'loop',
            )
          )
          ,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              RaisedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AvisList()));
                },
                child: Text('Afficher les avis'),
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => TestListPage()));
                },
                child: Text("S'inscrire à une classe"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
