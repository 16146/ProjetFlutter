import 'package:cloud_firestore/cloud_firestore.dart';

class Classes {
  final String nom;
  final String professeur;

  Classes(DocumentSnapshot snapshot)
    : nom = snapshot.documentID,
      professeur = snapshot.data['Professeur'];


  String toString() => "Classes($professeur)<$nom>";
}