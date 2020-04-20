import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:grades/models/classes.dart';
import 'package:grouped_buttons/grouped_buttons.dart';

class Poubelle extends StatefulWidget {
  _PoubelleState createState() => _PoubelleState();
}

class _PoubelleState extends State<Poubelle> {
  final _formKey = GlobalKey<FormState>();
  final _description = TextEditingController();
  final Firestore _db = Firestore.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging();
  //final _classes = TextEditingController();
  var _classes = List() ;

  String get checked => null;
  
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


  Widget build(BuildContext context) {
    Firestore.instance.collection('classes').getDocuments().then((snapshot) => {
      for (final i in range(0, snapshot.documents.length)) {
        _classes.add(snapshot.documents[i].documentID.toString()),
        //print(i),
        //print(_classes[i]),
      },
    });
    print(_classes);
    var liste = new List<String>.from(_classes);
    return Scaffold(
      appBar: AppBar(
        title: Text("S'inscrire à une ou plusieurs classes"),
        backgroundColor: Color(0xFF7E0000),
        
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
                FlatButton(
                child: Text('I like puppies'),
                onPressed: () => {_fcm.subscribeToTopic('puppies'),
                _fcm.requestNotificationPermissions(),
                }
            ),

            FlatButton(
                child: Text('I hate puppies'),
                onPressed: () => _fcm.unsubscribeFromTopic('puppies')
            ),
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
                      //if (value.isEmpty) {
                      //  return 'Please enter a description';
                      //}
                      return null;
                    },
                  ),
                  CheckboxGroup(
                        labels: liste,
                        onSelected: (List<String> checked) => [ 
                        print("glou"),
                        print(checked.toString())]
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

                      if (_formKey.currentState.validate()) {
                        //Firestore.instance
                         //   .collection('avis')
                         //   .document()
                         //   .setData(test);
                        //Navigator.pop(context);
                        print(checked);
                        _fcm.subscribeToTopic(checked);

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
