import 'package:flutter/material.dart';

AppBar defaultAppBar() {
  return AppBar(
    title: const Text("Bivouac"),
    actions: [
      IconButton(
        onPressed: () {},
        icon: const Icon(Icons.add, weight: 50, size: 35, color: Colors.black,),
      ),
    ],
  );
}