import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';

class AddAvis extends StatefulWidget {
  final classes;

  _AddAvisState createState() => _AddAvisState();
  AddAvis({Key key, @required this.classes}) : super(key: key);
}

class _AddAvisState extends State<AddAvis> {
  final _formKey = GlobalKey<FormState>();
  final _titre = TextEditingController();
  final _description = TextEditingController();
  // final Firestore _db = Firestore.instance;
  // final FirebaseMessaging _fcm = FirebaseMessaging();
  Map<String, bool> someMap = {  };

  //var _classes = List() ;
  var _checked = List(); 

  @override
  void dispose() {
    _titre.dispose();
    _description.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ajouter un avis"),
        backgroundColor: Color(0xFF7E0000),
        
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            children: <Widget>[
              Form( 
              key: _formKey,
                  child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: _titre,
                      decoration: const InputDecoration(
                        labelText: "Titre de l'avis",
                        hintText: 'Avis Important',
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Entrer un titre (court)';
                        }
                        return null;
                    },
                  ),
                    TextFormField(
                      controller: _description,
                      decoration: const InputDecoration(
                        labelText: "Description de l'avis",
                        hintText: 'Nouvelle description',
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Entrer une description';
                        }
                        return null;
                    },
                  ),
                  
                  CheckboxGroup(
                        labels: new List<String>.from(widget.classes),
                        onSelected: (List<String> checked) => [ 
                        _checked=checked,
                        ]
                    ),        
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  RaisedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    color:Colors.black,
                    child: Text("Annuler", 
                    style: TextStyle(fontSize: 17.0,color: Colors.white)),
                  ),
                  RaisedButton(
                    onPressed: () async {
                      print(_checked);
                      var classesChosen = new List<String>.from(_checked);
                      var test = {
                        'titre': _titre.text,
                        'description':_description.text,
                        'classes': classesChosen,
                      };

                      if (_formKey.currentState.validate()) {
                        Firestore.instance
                            .collection('avis')
                            .document()
                            .setData(test);

                        Navigator.pop(context);
                      }
                    },
                    color:Colors.red[900],
                    child: Text("Ajouter",
                    style: TextStyle(fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
                  ),
                ],
              ),
            ],
          ),
        ),
            ])
    );
  }
}