import 'package:bivouac/components/db_data_stream.dart';
import 'package:bivouac/components/mini_map.dart';
import 'package:bivouac/components/spacers.dart';
import 'package:bivouac/screens/bivouac_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Widget bivouacListTile(String id, BuildContext context){
  return DataStream(
    collection: "bivouacs", 
    id: id, 
    builder: (bData) {
      Timestamp startTime = bData['start_time'];

      return ListTile(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => BivouacScreen(id: id),));
        },
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 140,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  verticalSpacer(10),
                  Text(
                    bData['name'],
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  verticalSpacer(5),
                  Text(
                    startTime.toDate().toString().substring(0, 10),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[700]
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                  verticalSpacer(18),

                  DataStream(
                    collection: "users", 
                    id: bData['author'], 
                    builder: (authorData) {
                      return Text(
                        "by ${authorData['username']}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[700]
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      );
                    },
                  )
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: MiniMap(
                coordinates: bData['location'], 
                height: 100, 
                width: 100,
                zoom: 7,
              ),
            )
          ],
        )
      );
    },
  );
}