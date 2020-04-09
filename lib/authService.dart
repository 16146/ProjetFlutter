import 'package:firebase_auth/firebase_auth.dart';

import 'user.dart';

class AuthService
{
  final FirebaseAuth _auth = FirebaseAuth.instance;


  //create user obj base on FirebaseUser vidéo 6, le point 
  //d'interrogation veut dire si user!= null , alors User( ...
  //et si c'est pas vrai alors : null
  User _userFromFirebaserUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  //auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged
        //IDEM en bas en + rapide.map((FirebaseUser user) => _userFromFirebaserUser(user));
        .map(_userFromFirebaserUser);
  }

  Future signInAnon() async {
    try {
      AuthResult result =  await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaserUser(user);
    } catch(e){
      print(e.toString());
      return null;
    }
  }

  //S'inscrire avec email + mdp
  Future registerAvecMailEtPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email : email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaserUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  Future signInAvecMailEtPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email : email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaserUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }
  // DECONNECTION
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch(e) {
      print(e.toString());
      return null;
    }
  }
}