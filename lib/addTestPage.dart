import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddTestPage extends StatefulWidget {
  _AddTestPageState createState() => _AddTestPageState();
}

class _AddTestPageState extends State<AddTestPage> {
  final _formKey = GlobalKey<FormState>();
  final _matriculeController = TextEditingController();
  final _nameController = TextEditingController();
  final _dateController = TextEditingController();

  @override
  void dispose() {
    _matriculeController.dispose();
    _nameController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Test"),
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
                  /*TextFormField(
                    controller: _matriculeController,
                    decoration: const InputDecoration(
                      labelText: 'Matricule',
                      hintText: '123456',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter a matricule';
                      }
                      return null;
                    },
                  ),*/
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      hintText: 'Biology',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter a name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _dateController,
                    decoration: const InputDecoration(
                      labelText: 'Date',
                      hintText: '21/02/2020',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter a date';
                      }
                      else if (DateTime.tryParse(value) == null){
                        return 'Please enter a valid date';
                      }
                      return null;
                    },
                    onTap: () {
                      final future = showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2018),
                        lastDate: DateTime(2030),
                        builder: (BuildContext context, Widget child) {
                          return Theme(
                            data: ThemeData.dark(),
                            child: child,
                          );
                        },
                      ).then((date) {
                        _dateController.text = date.toString();
                      });
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
                    child: Text("Cancel"),
                  ),
                  RaisedButton(
                    onPressed: () {
                      var test = {
                        'name': _nameController.text,
                        'date': Timestamp.fromDate(DateTime.parse(_dateController.text))
                      };

                      //var matricule = _matriculeController.text;

                      if (_formKey.currentState.validate()) {
                        Firestore.instance
                            .collection('tests')
                            .document()
                            .setData(test);
                        Navigator.pop(context);
                      }
                    },
                    child: Text("Add"),
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
