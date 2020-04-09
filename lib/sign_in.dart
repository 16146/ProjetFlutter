import 'package:flutter/material.dart';
import 'package:grades/authService.dart';

import 'loading.dart';


class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({ this.toggleView });

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor :  Colors.brown[100],
      appBar: AppBar(
        title: Text("Connexion"),
        backgroundColor: Color(0xFF7E0000),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text("S'inscrire"),
            onPressed: () {
              widget.toggleView();
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Email existant',
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2.0)
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 2.0)
                  ),
                ),
                validator: (val) => val.isEmpty ? 'Entrer un email' : null,
                onChanged: (val) {
                  setState(() => email = val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Mot de passe',
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2.0)
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 2.0)
                  ),
                ),
                obscureText: true,
                validator: (val) => val.length < 6 ? 'Entrer un mot de passe de minimum 6 caractères' : null,
                onChanged: (val) {
                setState(() => password = val);
                },
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                color: Colors.red[900],
                child: Text("Se connecter",
                style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    setState(()=> loading=true);
                    dynamic result = await _auth.signInAvecMailEtPassword(email, password);
                    if (result ==  null){
                      setState(() {
                        error = 'Identifiants incorrects ou inexistants';
                        loading = false;
                      });
                    }
                  }
                },
              ),
              SizedBox(height:12.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              ),
            ],
          )
        )
      )
    );
  }
}