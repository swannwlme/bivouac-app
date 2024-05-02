import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth{
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => firebaseAuth.currentUser;
  Stream<User?> get authStateChanges => firebaseAuth.authStateChanges();

  final FirebaseStorage storage = FirebaseStorage.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> createUserWithEmailAndPassword(String email, String password) async {
    await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      Navigator.popUntil(context, (route) => route.isFirst);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> setUserData(Map<Object, Object?> data) async {
    users.doc(currentUser?.uid).set(data);
  }


  Future<void> updateUserData(Map<Object, Object?> data) async {
    users.doc(currentUser?.uid).update(data);
  }

  Future<void> createUserFile(String username, String description, List<double> location, String address) async {
    users.doc(currentUser?.uid).set({
      'username': username,
      'description': description,
      'bivouacs': [],
      'clan': null,
      'location': location,
      'address': address,
      
    });
  }

  Future<Map<String, dynamic>> getUserData() async {
    final userDoc = await users.doc(currentUser?.uid).get();
    return userDoc.data() as Map<String, dynamic>;
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  Future<bool> isUserCreated() async {
    final userDoc = await users.doc(currentUser?.uid).get();
    return userDoc.exists;
  }
}