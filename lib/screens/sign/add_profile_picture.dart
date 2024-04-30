import 'package:bivouac/components/default_buttons.dart';
import 'package:bivouac/components/profile_image.dart';
import 'package:bivouac/components/spacers.dart';
import 'package:flutter/material.dart';

class AddProfilePictureScreen extends StatefulWidget {
  const AddProfilePictureScreen({super.key});

  @override
  State<AddProfilePictureScreen> createState() => _AddProfilePictureScreenState();
}

class _AddProfilePictureScreenState extends State<AddProfilePictureScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PopScope(
        canPop: false,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Add a profile picture !",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
        
                  Center(
                    child: ProfileImage(
                      size: MediaQuery.of(context).size.width*0.4,
                      canModify: true,
                    )
                  ),

                  bigButton(
                    "Finish Inscription", 
                    () {
                      Navigator.pop(context);
                    }
                  )
                ],
              ),
            ),
          )
            ),
      )
    );
  }
}