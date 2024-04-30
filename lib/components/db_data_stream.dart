import 'package:bivouac/components/lodaing_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DataStream extends StatefulWidget {
  final String collection;
  final String id;
  final Widget Function(Map<String, dynamic> data) builder;
  
  const DataStream({super.key, required this.collection, required this.id, required this.builder,});

  @override
  State<DataStream> createState() => _DataStreamState();
}

class _DataStreamState extends State<DataStream> {
  Stream<DocumentSnapshot<Map<String, dynamic>>>? dataStream;

  @override
  void initState() {
    dataStream = FirebaseFirestore.instance
    .collection(widget.collection)
    .doc(widget.id).snapshots();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    if (dataStream==null){
      return  loadingIndicator(true);
    }
  
    return StreamBuilder(
      stream: dataStream, 
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





class CollectionStream extends StatefulWidget {
  final String collection;
  final Widget Function(Map<String, dynamic> data) builder;

  const CollectionStream({super.key, required this.collection, required this.builder});

  @override
  State<CollectionStream> createState() => _CollectionStreamState();
}

class _CollectionStreamState extends State<CollectionStream> {

  Stream<QuerySnapshot<Map<String, dynamic>>>? dataStream;

  @override
  void initState() {
    dataStream = FirebaseFirestore.instance
    .collection(widget.collection).snapshots();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (dataStream==null){
      return  loadingIndicator(true);
    }
  
    return StreamBuilder(
      stream: dataStream, 
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return loadingIndicator(true);
        }

        Map<String, dynamic> data = snapshot.data!.docs as Map<String, dynamic>;
        return widget.builder(data);
      },
    );
  }
}