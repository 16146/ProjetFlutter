import 'package:cloud_firestore/cloud_firestore.dart';
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
                    validator: (value) => value == '0000' ? "Code invalide" : null
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
                    style: TextStyle(color: Colors.white)),
                  ),
                  RaisedButton(
                    color: Colors.red[900],
                    onPressed: () {
                      //var student = {
                      //  'firstname': "_firstnameController.text",
                     // };

                      //var matricule = "_matriculeController.text";

                      if (_formKey.currentState.validate()) {
                        Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AdminPage()));
                      }
                    },
                    child: Text("Accéder",
                    style: TextStyle(color: Colors.white)),
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
