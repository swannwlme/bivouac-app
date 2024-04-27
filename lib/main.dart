import 'package:bivouac/screens/sign/auth_selection_screen.dart';
import 'package:flutter/material.dart';
import 'package:bivouac/theme/theme_constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bivouac',
      theme: ThemeConstants.lightTheme,
      home: const AuthSelectionScreen(),
    );
  }
}