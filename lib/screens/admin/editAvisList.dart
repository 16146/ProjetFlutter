import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grades/models/avis.dart';
import 'package:grades/screens/admin/addAvis.dart';

class AvisListAdmin extends StatefulWidget {
  @override
  _AvisListAdmin createState() {
    return _AvisListAdmin();
  }
}

Iterable<int> range(int low, int high) sync* {
    for (int i = low; i < high; ++i) {
      yield i;
    }
}
class _AvisListAdmin extends State<AvisListAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Liste des avis'), backgroundColor: Color(0xFF7E0000),),
      body: _buildBody(context),
       floatingActionButton: FloatingActionButton(
      onPressed: () async {
        List _classes;
        await Firestore.instance.collection('classes').getDocuments().then((snapshot) => {
          _classes=List(),
            for (final i in range(0, snapshot.documents.length)) {
              _classes.add(snapshot.documents[i].documentID.toString()),
            },
          });
          Navigator.push(
          context,
          MaterialPageRoute(
          builder: (context) => AddAvis(classes: _classes)));
          },
          backgroundColor: Colors.red[900],
         child: Icon(Icons.add,
         ),
       ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('avis').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final avis = Avis(data);

    return Padding(
      key: ValueKey(avis.id),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          title: Row( mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(avis.titre),
                  Text((avis.classes).toString()),]
          ),
          subtitle: RaisedButton(
          
            color: Colors.black,
            child: Text("Supprimer l'avis",
            style: TextStyle(color: Colors.white)),
            onPressed: () {
              Firestore.instance.collection("avis").document(avis.id).delete();}
          ),
          onTap: () =>
          showDialog (
          context: context,
          builder : (context) => AlertDialog(
            content: ListTile(
              title: Row( mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(avis.titre),
                  Text((avis.classes).toString()),]
          ),
              subtitle: Text(avis.description),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () =>Navigator.of(context).pop(),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
