import 'package:flutter/material.dart';
import 'package:grades/addAvis.dart';
import 'package:grades/admin/addClass.dart';
import 'package:grades/authService.dart';
import 'package:grades/avisList.dart';
import 'package:grades/homePage.dart';
import 'package:grades/testListPage.dart';

class AdminPage extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text("Page Admin"),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  RaisedButton(
                    color: Colors.red[900],
                    child: Text('Ajouter un avis',
                    style: TextStyle(color: Colors.white,
                    fontSize:25.0)),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddAvis()));
                    },
                  ),
                ],
                ),
              Row ( 
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  RaisedButton(
                    color: Colors.red[900],
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => AddClass()));
                    },
                    child: Text("Ajouter une classe",
                    style: TextStyle(color: Colors.white,
                    fontSize:25.0)),
                  ),
                ],
              ),
              Row ( 
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  RaisedButton(
                    color: Colors.red[900],
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => TestListPage()));
                    },
                    child: Text("Supprimer une ou plusieurs classe(s)",
                    style: TextStyle(color: Colors.white,
                    fontSize:20.0)),
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
                        MaterialPageRoute(builder: (context) => HomePage())
                        );
                    },
                    child: Text("Retour",
                    style: TextStyle(color: Colors.white,
                    fontSize:25.0)),
                  ),
                ]
              ),
            ],
          ),
      )  )));
  }
}
