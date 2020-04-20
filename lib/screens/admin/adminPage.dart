import 'package:flutter/material.dart';
import 'package:grades/screens/admin/editAvisList.dart';
import 'package:grades/screens/admin/editClassList.dart';
import 'package:grades/services/authService.dart';

class AdminPage extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFF0),
      appBar: AppBar(
        title: Text("Page Admin"),
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
                    child: Text('Gérer les avis',
                    style: TextStyle(color: Colors.white,
                    fontSize:25.0)),
                    onPressed: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AvisListAdmin()));
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
                      fontSize:25.0)
                      ),
                    ),
                  ],
                ),
                Row ( 
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    RaisedButton(
                      color: Colors.black,
                      onPressed: () {
                        Navigator.popUntil(context, ModalRoute.withName('/'));
                      },
                      child: Text("Retour",
                      style: TextStyle(color: Colors.white,
                      fontSize:25.0)
                      ),
                    ),
                  ]
                ),
              ],
            ),
          )  
        )
      )
    );
  }
}
