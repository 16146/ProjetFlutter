import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grades/screens/admin/addAvis.dart';
import 'package:grades/screens/admin/addClass.dart';
import 'package:grades/screens/admin/editClassList.dart';
import 'package:grades/services/authService.dart';
import 'package:grades/screens/avisList.dart';
import 'package:grades/screens/homePage.dart';

Iterable<int> range(int low, int high) sync* {
    for (int i = low; i < high; ++i) {
      yield i;
    }
}

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
                    onPressed: () async {
                      List _classes;
                      await Firestore.instance.collection('classes').getDocuments().then((snapshot) => {
                        _classes=List(),
                        for (final i in range(0, snapshot.documents.length)) {
                          _classes.add(snapshot.documents[i].documentID.toString()),
                        },
                      });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddAvis(classes: _classes)));
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
                          MaterialPageRoute(builder: (context) => EditClassList()));
                    },
                    child: Text("Gérer les classes",
                    style: TextStyle(color: Colors.white,
                    fontSize:25.0)),
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
