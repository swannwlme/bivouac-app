import 'package:bivouac/components/lodaing_indicator.dart';
import 'package:bivouac/database/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserStreamBuilder extends StatefulWidget {
  final String? uid;
  final Widget Function(Map<String, dynamic> data) builder;
  
  const UserStreamBuilder({super.key, required this.builder, this.uid});

  @override
  State<UserStreamBuilder> createState() => _UserStreamBuilderState();
}

class _UserStreamBuilderState extends State<UserStreamBuilder> {
  Stream<DocumentSnapshot<Map<String, dynamic>>>? _usersStream;

  @override
  void initState() {
    if(widget.uid != null){
      _usersStream = FirebaseFirestore.instance
      .collection('users')
      .doc(widget.uid).snapshots();
    } else {
      _usersStream = FirebaseFirestore.instance
      .collection('users')
      .doc(Auth().currentUser!.uid).snapshots();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    if (_usersStream==null){
      return  loadingIndicator(true);
    }
  
    return StreamBuilder(
      stream: _usersStream, 
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return loadingIndicator(true);
        }

        Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
        return widget.builder(data);
      },
    );
  }
}