import 'dart:io';

import 'package:bivouac/components/default_appbar.dart';
import 'package:bivouac/components/default_buttons.dart';
import 'package:bivouac/utils/get_image.dart';
import 'package:flutter/material.dart';
import 'package:reorderables/reorderables.dart';

class AddPicturesScreen extends StatefulWidget {
  final void Function(List<File>) updateScreen;
  final List<File>? currentImages;
  const AddPicturesScreen({super.key, required this.updateScreen, this.currentImages});

  @override
  State<AddPicturesScreen> createState() => _AddPicturesScreenState();
}

class _AddPicturesScreenState extends State<AddPicturesScreen> {

  List<File> images = [];

  List<Widget> buildImage = [];

  void addImage(File image) {
    setState(() {
      images.add(image);
      buildImage.add(
        GestureDetector(
          onTap: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Confirm Deletion'),
                    content: const Text('Are you sure you want to delete this image?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          setState(() {
                            buildImage.removeAt(images.indexOf(image));
                            images.remove(image);
                            Navigator.pop(context);
                          });
                        },
                        child: const Text('Delete'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Cancel'),
                      ),
                    ],
                  );
                },
              );
          },
          child: Card(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                height: 200,
                width: 120,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: MemoryImage(image.readAsBytesSync()),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  @override
  void initState() {
    if (widget.currentImages != null) {
      images = widget.currentImages!;
      for (File image in images) {
        buildImage.add(
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Confirm Deletion'),
                    content: const Text('Are you sure you want to delete this image?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          setState(() {
                            buildImage.removeAt(images.indexOf(image));
                            images.remove(image);
                            Navigator.pop(context);
                          });
                        },
                        child: const Text('Delete'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Cancel'),
                      ),
                    ],
                  );
                },
              );
            },
            child: Card(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  height: 200,
                  width: 120,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: MemoryImage(image.readAsBytesSync()),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }
    }

    // buildImage.add(
    //   GestureDetector(
    //     onTap: () {
    //       getImage().then((value) {
    //         if (value.path != '') {
    //           addImage(value);
    //         }
    //       });
    //     },
    //     child: const Card(
    //       child: SizedBox(
    //         height: 200,
    //         width: 120,
    //         child: Icon(Icons.add, color: Colors.grey, size: 50),
    //       ),
    //     ),
    //   )
    // );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(
        context,
        showBackButton: true,
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.only(left: 25, right: 25, bottom: 30),
        child: bigButton(
          "Save Pictures", 
          () {
            widget.updateScreen(images);
            Navigator.pop(context);
          }
        ),
      ),

      body: ReorderableWrap(
        onReorder: (int oldIndex, int newIndex) {
          setState(() {
            File image = images.removeAt(oldIndex);
            images.insert(newIndex, image);

            Widget imageWidget = buildImage.removeAt(oldIndex);
            buildImage.insert(newIndex, imageWidget);
          });
        },
        header: [
          GestureDetector(
            onTap: () {
              getImage().then((value) {
                if (value.path != '') {
                  addImage(value);
                }
              });
            },
            child: const Card(
              child: SizedBox(
                height: 200,
                width: 120,
                child: Icon(Icons.add, color: Colors.grey, size: 50),
              ),
            ),
          )
        ],
        children: buildImage,
      )
    );
  }
}