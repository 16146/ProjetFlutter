import 'package:cloud_firestore/cloud_firestore.dart';

class Avis {
  final String id;
  final String description;
  final List classes;

  Avis(DocumentSnapshot snapshot)
    : id = snapshot.documentID,
      description = snapshot.data['description'],
      classes = snapshot.data['classes'] ;

  String get _description => "$description";

  String toString() => "Avis($id)<description: $_description, classes: $classes>";
}