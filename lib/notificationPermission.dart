import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:grades/models/classes.dart';
import 'package:grades/models/user.dart';
import 'package:grouped_buttons/grouped_buttons.dart';

class NotificationPermission extends StatefulWidget {
  _NotificationPermissionState createState() => _NotificationPermissionState();
}

class _NotificationPermissionState extends State<NotificationPermission> {
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

  @override
  void initState() {
    super.initState();
    _fcm.configure(
      onMessage:(Map<String, dynamic> message) async {
        print("onMessage: $message");
         final snackbar= SnackBar(
           content: Text(message['notification']['title']),
           action: SnackBarAction(
             label: 'Go',
             onPressed: ()=>null,
           ),
         );
         Scaffold.of(context).showSnackBar(snackbar);
        showDialog (
          context: context,
          builder : (context) => AlertDialog(
            content: ListTile(
              title: Text(message['notification']['title']),
              subtitle: Text(message['notification']['body']),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () =>Navigator.of(context).pop(),
              )
            ],
          )
        );
      },
      onResume:(Map<String, dynamic> message) async {
        print("onResume: $message");
      },
      onLaunch:(Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
    );
     
    if (Platform.isIOS) {
      var iosSubscription = _fcm.onIosSettingsRegistered.listen((data) {
        _saveDeviceToken();
      });
      _fcm.requestNotificationPermissions(
      IosNotificationSettings(),
    );
    
    } else {
      _saveDeviceToken();
    }
  }
///Get the token, save it to the database for current user
  _saveDeviceToken() async {
    String fcmToken = await _fcm.getToken();
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    String uid = user.email;
     if ( fcmToken != null)
     {
       var tokenRef = _db
       .collection('users')
       .document(uid)
       .collection('tokens')
       .document(fcmToken);
       await tokenRef.setData({
         'token' : fcmToken,
          'platform': "Android"
       });
     }
  }




  Iterable<int> range(int low, int high) sync* {
    for (int i = low; i < high; ++i) {
      yield i;
    }
  }


  Widget build(BuildContext context) {
    Firestore.instance.collection('classes').getDocuments().then((snapshot) => {
      //for (final i in range(0, snapshot.documents.length)) {
      //  _classes.add(snapshot.documents[i].documentID.toString()),
        //print(i),
        //print(_classes[i]),
      //},
    });
    print(_classes);
    print("EAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
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
                        print("mouk en bermuda");
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
