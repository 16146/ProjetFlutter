import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:grades/models/classes.dart';
import 'package:grouped_buttons/grouped_buttons.dart';

class AddAvis extends StatefulWidget {
  _AddAvisState createState() => _AddAvisState();
}

class _AddAvisState extends State<AddAvis> {
  final _formKey = GlobalKey<FormState>();
  final _description = TextEditingController();
  final Firestore _db = Firestore.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging();
  Map<String, bool> someMap = {  };
  final List<String> _selectedClasses = List<String>();
  //final _classes = TextEditingController();
  var _classes = List() ;
  var _checked = List(); 

  void _onClassesSelected(bool value, key) {
    if (value == true) {
      setState(() {
        someMap[key] = value;
        _selectedClasses.add(key);
        print(_selectedClasses);
      });
    } else {
      setState(() {
        someMap[key] = value;
        _selectedClasses.remove(key);
        print(_selectedClasses);
      });
    }
  }

  @override
  void dispose() {
    _description.dispose();
    //_classes.dispose();
    super.dispose();
  }
  Iterable<int> range(int low, int high) sync* {
    for (int i = low; i < high; ++i) {
      yield i;
    }
  }
  @override
  void initState()  {
    super.initState();
     Firestore.instance.collection('classes').getDocuments().then((snapshot) => {
      for (final i in range(0, snapshot.documents.length)) {
        _classes.add(snapshot.documents[i].documentID.toString()),
        print(i),
        print(_classes[i]),
      },
    });
  }

  Widget build(BuildContext context) {
    print(_classes);
    var liste = new List<String>.from(_classes);
    print(liste);
    /*final classes = Provider.of<List<Classes>>(context);
    for (var clas in classes) {
      someMap.putIfAbsent(clas.nom, () => false);
    }*/

    return Scaffold(
      appBar: AppBar(
        title: Text("Ajouter un avis"),
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
            
                    controller: _description,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      hintText: 'Nouvelle description',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter a description';
                      }
                      return null;
                    },
                  ),
                  
                  /*CheckboxGroup(
                        labels: liste,
                        onSelected: (List<String> checked) => [ 
                        _checked=checked,
                        print(_checked),
                        print(checked),
                        ]
                    ),*/
                  
                  ListView(
                    children: someMap.keys.map((String key) {
                      return CheckboxListTile(
                        title: Text(key),
                        value: someMap[key],
                        onChanged: (bool value) {
                          setState(() {
                            _onClassesSelected(value, key);
                          });
                        },
                      );
                    }).toList(),
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
                      print(_checked);
                      var classes = new List<String>.from(_checked);
                      print(classes.toList());
                      var test = {
                        'Description':_description.text,
                        'classes': classes,
                      };

                      if (_formKey.currentState.validate()) {
                        Firestore.instance
                            .collection('avis')
                            .document()
                            .setData(test);

                        Navigator.pop(context);
                        print(_checked);
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