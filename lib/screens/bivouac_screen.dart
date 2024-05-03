import 'package:bivouac/components/db_data_stream.dart';
import 'package:bivouac/components/default_appbar.dart';
import 'package:bivouac/components/image_slide.dart';
import 'package:bivouac/components/profile_image.dart';
import 'package:bivouac/components/spacers.dart';
import 'package:bivouac/components/vertical_divider.dart';
import 'package:bivouac/utils/time_maths.dart';
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
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                        showLocation: true,
                        coordinates: data['location'],
                      ),
                    ),

                    verticalSpacer(20),

                    Text(
                      data['name'],
                      style: const TextStyle(
                        fontSize: 20,
                        letterSpacing: 0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    verticalSpacer(3),
                    Text(
                      data['description'],
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700]
                      ),
                    ),

                    verticalSpacer(20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Duration",
                              style: TextStyle(
                                fontSize: 15,
                                letterSpacing: 0,
                                color: Colors.grey[700]
                              ),
                            ),
                            Text(
                              "${durationFromData(data['start_time'], data['end_time'])} days",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            )
                          ],
                        ),

                        verticalDivider(30),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Members",
                              style: TextStyle(
                                fontSize: 15,
                                letterSpacing: 0,
                                color: Colors.grey[700]
                              ),
                            ),
                            Text(
                              data['members'].length<=1 ? "${data['members'].length.toString()} person" : "${data['members'].length.toString()} people",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),

                    verticalSpacer(30),

                    const Text(
                      "Members",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    
                    verticalSpacer(10),

                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: data['members'].length,
                      itemBuilder: (context, index) {
                        return DataStream(
                          collection: "users", 
                          id: data['members'][index], 
                          builder: (mData) {
                            return Row(
                              children: [
                                ProfileImage(
                                  uid: data['members'][index],
                                  size: 20,
                                ),
                                horizontalSpacer(15),
                                Text(
                                  mData['username'],
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
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