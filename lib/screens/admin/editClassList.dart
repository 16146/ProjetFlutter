import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grades/screens/admin/addClass.dart';
import 'package:grades/models/classes.dart';

class EditClassList extends StatefulWidget {
  @override
  _EditClassList createState() {
    return _EditClassList();
  }
}

class _EditClassList extends State<EditClassList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Liste des classes'), backgroundColor: Color(0xFF7E0000),),
      body: _buildBody(context),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red[900],
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddClass()));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('classes').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 25.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final classe = Classes(data);

    return Padding(
      key: ValueKey(classe.nom),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          title: 
          Row( mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(classe.nom),
                  Text("Professeur " + (classe.professeur).toString()),]
          ),
          subtitle: RaisedButton(
            color: Colors.black,
            child: Text("Supprimer la classe",
            style: TextStyle(color: Colors.white)),
            onPressed: () {
              Firestore.instance.collection("classes").document(classe.nom).delete();}
          ),
          onTap: () => print(classe),
        ),
      ),
    );
  }
}
