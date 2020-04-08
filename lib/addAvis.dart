import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';

class AddAvis extends StatefulWidget {
  _AddAvisState createState() => _AddAvisState();
}

class _AddAvisState extends State<AddAvis> {
  final _formKey = GlobalKey<FormState>();
  final _description = TextEditingController();
  //final _classes = TextEditingController();
  var _classes = List();
  bool monVal = false;
  bool tuVal = false;
  bool wedVal = false;
  bool thurVal = false;
  bool friVal = false;
  bool satVal = false;
  bool sunVal = false;
  
  @override
  void dispose() {
    _description.dispose();
    //_classes.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
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
                  //TextFormField(
                  //  controller: _classes,
                  //  decoration: const InputDecoration(
                  //    labelText: 'Classes',
                  //    hintText: '1A',
                   // ),
                    //validator: (value) {
                     // if (value.isEmpty) {
                     //   return 'Please enter a class or more';
                     // }
                     // return null;
                    //}
                  //),
                  CheckboxGroup(
                        labels: <String>[
                          "Sunday",
                          "Monday",
                          "Tuesday",
                          "Wednesday",
                          "Thursday",
                          "Friday",
                          "Saturday",
                        ],
                        onSelected: (List<String> checked) => [ print(checked.toString()),_classes = checked]
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
                        'Description': _description.text,
                        'classes': _classes,
                      };
                      print(test);

                      if (_formKey.currentState.validate()) {
                        Firestore.instance
                            .collection('avis')
                            .document()
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
