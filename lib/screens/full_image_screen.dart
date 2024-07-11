import 'package:bivouac/theme/color_palet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class FullImageScreen extends StatefulWidget {
  List<Widget> imageList = [];
  FullImageScreen({super.key, required this.imageList});

  @override
  State<FullImageScreen> createState() => _FullImageScreenState();
}

class _FullImageScreenState extends State<FullImageScreen> {

  bool isFocused = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isFocused ? Colors.black : Colpal.white,
      body: GestureDetector(
        onTap: () {
          setState(() {
            isFocused = !isFocused;
          });
        },
        child: Stack(
          children: [
            SafeArea(
              child: isFocused ? Container() : Padding(
                padding: const EdgeInsets.all(10),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            Center(
              child: ImageSlideshow(
                isLoop: false,
                indicatorColor: Colpal.white,
                indicatorPadding: 5,
                children: widget.imageList,
              ),
            ),
          ]
        ),
      ),
    );
  }
}