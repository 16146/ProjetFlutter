import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grades/screens/admin/adminPage.dart';
import 'package:grades/screens/loading.dart';

class AddClass extends StatefulWidget {
  _AddClassState createState() => _AddClassState();
}

class _AddClassState extends State<AddClass> {
  final _formKey = GlobalKey<FormState>();
  final _classe = TextEditingController();
  final _professeur = TextEditingController();
  bool loading = false; 
  @override
  void dispose() {
    _classe.dispose();
    _professeur.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return loading ? Loading : Scaffold(
      
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
                      hintText: '1A',
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
                        return 'Champs vide, entrer une nouvelle classe';
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
                    onPressed: () async {
                      try 
                      {
                        var res =  await (Firestore.instance.collection('classes').document(_classe.text)).get();
                        if (res.data == null)  
                        {
                          var test = {
                            'Professeur': _professeur.text,
                          };
                          if (_formKey.currentState.validate()) {
                          Firestore.instance
                              .collection('classes')
                              .document(_classe.text)
                              .setData(test);
                          Navigator.push(context, 
                          MaterialPageRoute(builder: (context) => AdminPage())
                          );
                          setState(() => loading = false); 
                          }
                        } else {
                          showDialog( 
                            context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Attention"),
                                  content: Text("Classe déjà existante, vous êtes sur le point de l'éditer. Êtes-vous sûr de vouloir continuer ?"),
                                  actions: <Widget>[
                                    new FlatButton(
                                      child: Text("Retour en arrière"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    new FlatButton(
                                      child: Text("Continuer"),
                                      onPressed: () {
                                        var test = {
                                        'Professeur': _professeur.text,
                                        };
                                        if (_formKey.currentState.validate()) {
                                        Firestore.instance
                                            .collection('classes')
                                            .document(_classe.text)
                                            .setData(test);
                                        Navigator.push(context,
                                        MaterialPageRoute(builder: (context) => AdminPage())
                                        );
                                        setState(() => loading = false); 
                                        }
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        
                      } catch (err) {
                        print(err);
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
