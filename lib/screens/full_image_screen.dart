import 'dart:typed_data';

import 'package:bivouac/theme/color_palet.dart';
import 'package:bivouac/utils/image_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class FullImageScreen extends StatefulWidget {
  final Widget image;
  const FullImageScreen({super.key, required this.image});

  @override
  State<FullImageScreen> createState() => _FullImageScreenState();
}

class _FullImageScreenState extends State<FullImageScreen> {

  bool isFocused = false;
  Image? structImage;

  @override
  void initState() {
    super.initState();
    structImage = widget.image as Image;
  }

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
            Container(
              height: double.infinity,
              width: double.infinity,
              color: isFocused ? Colors.black : Colpal.white,
            ),
            SafeArea(
              child: isFocused ? Container() : Padding(
                padding: const EdgeInsets.all(10),
                child: Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),

                      IconButton(
                        icon: const Icon(Icons.download_rounded),
                        iconSize: 30,
                        onPressed: () async {
                          // Download image
                          if (structImage != null){
                          NetworkImage toSaveImage = structImage!.image as NetworkImage;
                            await saveNetworkImage(toSaveImage.url, "bivouac").then(
                              (value) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Image saved to gallery"),
                                  ),
                                );
                              },
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Center(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: structImage ?? Container(),
                ),
              ),
            ),
          ]
        ),
      ),
    );
  }
}