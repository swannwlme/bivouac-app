import 'package:bivouac/database/auth.dart';
import 'package:bivouac/screens/screen_projector.dart';
import 'package:bivouac/screens/sign/auth_selection_screen.dart';
import 'package:flutter/material.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges , 
      builder: (context, snapshot) {
        if (snapshot.hasData){
          return const ScreenProjector();
        } else {
          return const AuthSelectionScreen();
        }
      },
    );
  }
}