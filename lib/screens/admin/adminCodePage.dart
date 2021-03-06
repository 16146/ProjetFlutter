import 'package:flutter/material.dart';
import 'package:grades/screens/admin/adminPage.dart';

class AdminCodePage extends StatefulWidget {
  _AdminCodePageState createState() => _AdminCodePageState();
}

class _AdminCodePageState extends State<AdminCodePage> {
  final _formKey = GlobalKey<FormState>();
  final _codeSecret = TextEditingController();
  @override
  void dispose() {
    _codeSecret.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFF0),
      appBar: AppBar(
        title: Text("Accéder aux fonctionnalités admin"),
        backgroundColor: Color(0xFF7E0000),
      ),
      body: Container(
        
        margin: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Expanded(
                child: Column(
                children: <Widget>[
                  Text("Entrez le code administrateur :",
                  style: TextStyle(fontSize : 20.0)
                  ),
                  TextFormField(
                    obscureText: true,
                    controller: _codeSecret,
                    decoration: const InputDecoration(
                      labelText: 'Entrez le code secret (=0000)',
                      hintText: '########',
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2.0)
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 2.0)
                      ),        
                    ),
                    validator: (value) 
                    {
                      if (value.isEmpty) {
                        return 'Veuiller entrer un code valide';
                      } else if (value != "0000") {

                        return 'Code invalide';
                      }
                      return null;
                    }
                  ),
                ],
              )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  RaisedButton(
                    color: Colors.black,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Retour au menu principal",
                    style: TextStyle(color: Colors.white,
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold)),
                  ),
                  RaisedButton(
                    color: Colors.red[900],
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AdminPage()));
                      }
                    },
                    child: Text("Accéder",
                    style: TextStyle(color: Colors.white,
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                    )),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
