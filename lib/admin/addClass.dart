import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:grades/classes.dart';

class AddClass extends StatefulWidget {
  _AddClassState createState() => _AddClassState();
}

class _AddClassState extends State<AddClass> {
  final _formKey = GlobalKey<FormState>();
  final _classe = TextEditingController();
  final _professeur = TextEditingController();
  
  @override
  void dispose() {
    _classe.dispose();
    _professeur.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: Text("Ajouter une classe"),
        backgroundColor: Color(0xFF7E0000),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
               Expanded(
                  child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _classe,
                    decoration: const InputDecoration(
                      labelText: 'Ajouter une nouvelle classe',
                      hintText: '10C',
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2.0)
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 2.0)
                      ),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Entrer une nouvelle classe';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _professeur,
                    decoration: const InputDecoration(
                      labelText: 'Ajouter un nom de professeur',
                      hintText: 'Beaulieu',
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2.0)
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 2.0)
                      ),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Entrer un nom de professeur';
                      }
                      return null;
                    },
                  ),
                ],
              )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  RaisedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Annuler"),
                  ),
                  RaisedButton(
                    onPressed: () {
                      var test = {
                        'Professeur': _professeur.text,
                      };
                      print(test);

                      if (_formKey.currentState.validate()) {
                        Firestore.instance
                            .collection('classes')
                            .document(_classe.text)
                            .setData(test);
                        Navigator.pop(context);
                      }
                    },
                    child: Text("Ajouter"),
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
