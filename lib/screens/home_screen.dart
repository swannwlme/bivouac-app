import 'package:bivouac/components/default_buttons.dart';
import 'package:bivouac/database/auth.dart';
import 'package:flutter/material.dart';
import 'package:bivouac/components/app_icon.dart';
import 'package:bivouac/components/spacers.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      appIcon(width: 40),
                      horizontalSpacer(10),
                      const Text(
                        "Bivouac",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w800,
                        ),
                      ),

                      const Spacer(),

                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.add, weight: 50, size: 35, color: Colors.black,),
                      ),
                    ],
                  )
                ),

                verticalSpacer(10),

                const Divider(),

                bigButton("Sign out", () {
                  Auth().signOut();
                })
              ],
            ),
          ),
        ),
      )
    );
  }
}