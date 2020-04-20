import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:grades/models/classes.dart';


class SubscribeClass extends StatefulWidget {
  @override
  _SubscribeClassState createState() {
    return _SubscribeClassState();
  }
}

class _SubscribeClassState extends State<SubscribeClass> {
  final FirebaseMessaging _fcm = FirebaseMessaging();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Liste des classes'), backgroundColor: Color(0xFF7E0000),),
      body: _buildBody(context),
      //floatingActionButton: FloatingActionButton(
      //  onPressed: () {
      //    Navigator.push(context,
      //        MaterialPageRoute(builder: (context) => AddAvis()));
      //  },
      //  child: Icon(Icons.add),
      //),
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
      padding: const EdgeInsets.only(top: 20.0),
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
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          title: Row (
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children : [
              Text(
                "Classe: " + classe.nom,
                style: TextStyle(fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                )
              ), 
              Text(
                "Professeur: " +(classe.professeur).toString(),
                style: TextStyle(fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                )
              )
            ]
          ),
          subtitle: Row (
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RaisedButton(
                color: Colors.red[900],
                child: Text("S'abonner",
                style: TextStyle(color: Colors.white)),
                onPressed: () {
                  _fcm.subscribeToTopic(classe.nom);
                  }
              ),
              RaisedButton(
                color: Colors.black,
                child: Text("Se désabonner",
                style: TextStyle(color: Colors.white)),
                onPressed: () {
                  _fcm.unsubscribeFromTopic(classe.nom);
                  }
              )
            ]   
        ),
          
          onTap: () => print(classe),
        ),
      ),
    );
  }
}
