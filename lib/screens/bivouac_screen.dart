import 'package:bivouac/components/db_data_stream.dart';
import 'package:bivouac/components/default_appbar.dart';
import 'package:bivouac/components/image_slide.dart';
import 'package:bivouac/components/profile_image.dart';
import 'package:bivouac/components/spacers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BivouacScreen extends StatefulWidget {
  final String id;
  const BivouacScreen({super.key, required this.id});

  @override
  State<BivouacScreen> createState() => _BivouacScreenState();
}

class _BivouacScreenState extends State<BivouacScreen> {
  @override
  Widget build(BuildContext context) {
    return DataStream(
      collection: "bivouacs", 
      id: widget.id, 
      builder: (data) {

        List<String> images = data['images'].cast<String>();

        return Scaffold(
          appBar: defaultAppBar(context, showBackButton: true),
          body: SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [                
                    DataStream(
                      collection: "users", 
                      id: data['author'], 
                      builder: (uData) {
                        
                        Timestamp startTime = data['start_time'];

                        return Row(
                          children: [
                            ProfileImage(
                              uid: data['author'],
                              size: 25,
                            ),
                            horizontalSpacer(15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  uData['username'],
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),

                                Text(
                                  startTime.toDate().toString().substring(0, 10),
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),

                    verticalSpacer(20),
                
                    Center(
                      child: ImageSlide(
                        images: images,
                        height: 350,
                        width: 350,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}