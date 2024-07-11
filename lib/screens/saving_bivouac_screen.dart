import 'dart:io';

import 'package:bivouac/database/auth.dart';
import 'package:bivouac/database/data_storage.dart';
import 'package:bivouac/utils/random_utils.dart';
import 'package:flutter/material.dart';

class SavingBivouacScreen extends StatefulWidget {
  final String? id;
  final Map<String, dynamic> data;
  const SavingBivouacScreen({super.key, required this.data, this.id});

  @override
  State<SavingBivouacScreen> createState() => _SavingBivouacScreenState();
}

class _SavingBivouacScreenState extends State<SavingBivouacScreen> {

  Map<String, dynamic> finalData = {};

  @override
  void initState() {
    saveData();
    super.initState();
  }

  void saveData() async {

    print("Saving bivouac ");
    
    // int docId = await FirebaseFirestore.instance.collection('bivouacs').snapshots().length;
    String docId = widget.id ?? randomDocId();

    print("Choosing bivouac number $docId");

    finalData["name"] = widget.data["name"];
    finalData["location"] = widget.data["location"];
    finalData["description"] = widget.data["description"];
    finalData["start_time"] = widget.data["start_time"];
    finalData["end_time"] = widget.data["end_time"];
    finalData["author"] = widget.data["author"];
    finalData["members"] = widget.data["members"];

    finalData["images"] = [];

    print("simple Data saved");

    if (widget.data["clan"]) {
      await Auth().getUserData().then((value) {
        finalData["clan"] = value["name"];
      });
    } else {
      finalData["clan"] = null;
    }

    print("Saving images");

    int i=0;
    for (File image in widget.data["images"]) {
      await DataStorage().uploadFile("bivouacs/${widget.id ?? docId.toString()}/${i.toString()}", image).then((value) {
        finalData["images"].add(value);
      });
      i++;
    }

    print("Saving bivouac doc");

    await Auth().saveDoc(finalData, "bivouacs/${widget.id ?? docId}").then((value) async{
      await Auth().addBivouacToUser(widget.id ??  docId.toString()).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Bivouac saved successfully"),
          duration: Duration(seconds: 2),
        ));

        Navigator.pop(context);
      });
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return const PopScope(
      canPop: false,
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Saving bivouac...",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
            ),
            Center(child: CircularProgressIndicator()),
          ],
        )
      ),
    );
  }
}