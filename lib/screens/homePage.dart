import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:grades/screens/admin/adminCodePage.dart';
import 'package:grades/services/authService.dart';
import 'package:grades/screens/subscribeClass.dart';
import 'package:grades/screens/avisList.dart';

class HomePage extends StatelessWidget {
  final AuthService _auth = AuthService();

  // Future<void> _handleNotification (Map<dynamic, dynamic> message, bool dialog) async {
  //   var data = message['data'] ?? message;
  //   String expectedAttribute = data['expectedAttribute'];
  //   /// [...]
  // }
  
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
              Container(
                width: 400,
                child: Text(                  
                  "Bienvenue sur l'application officielle de l'Ecole Sud d'Arthedain. \n Accédez sans plus attendre aux fonctionnalités de l'application !",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 5,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black,fontSize: 17.0, fontWeight: FontWeight.bold,),
                ),
                alignment: Alignment.center,
                margin: new EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.red[900],                   
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.all(
                      Radius.circular(25.0)                 
                  ),
                ),
              ),
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
                    style: TextStyle(color: Colors.white,fontSize: 17.0,)),
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
                          MaterialPageRoute(builder: (context) => SubscribeClass()));
                    },
                    child: Text("S'abonner à une classe",
                    style: TextStyle(color: Colors.white,fontSize: 17.0,)),
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
                    style: TextStyle(color: Colors.white,fontSize: 17.0,)),
                  ),
                ]
              ),
            ],
          ),
      )  )));
  }
}
