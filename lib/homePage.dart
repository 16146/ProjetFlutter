import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:grades/adminCodePage.dart';
import 'package:grades/authService.dart';
import 'studentListPage.dart';
import 'avisList.dart';
import 'testListPage.dart';

class HomePage extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFF0),
      appBar: AppBar(
        title: Text("Ecole Sud d'Arthedain"),
        //COlor obligé 0XFF + color Hex (6 bits)
        backgroundColor: Color(0xFF7E0000),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Se déconnecter'),
            onPressed: () async {
              await _auth.signOut();
            },
          )
        ]
      ),
      body: new Center(
        child: new SingleChildScrollView(
          child: new Container(
            margin: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
            child: new Column( children: <Widget>[
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
                    color: Colors.red[900],
                    child: Text('Afficher les avis',
                    style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AvisList()));
                    },
                  ),
                  RaisedButton(
                    color: Colors.red[900],
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => TestListPage()));
                    },
                    child: Text("S'inscrire à une classe",
                    style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
              Row ( 
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  RaisedButton(
                    color: Colors.black,
                    onPressed: () {
                      Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AdminCodePage()));
                    },
                    child: Text("Accéder aux fonctions admin",
                    style: TextStyle(color: Colors.white)),
                  ),
                ]
              ),
            ],
          ),
      )  )));
  }
}
