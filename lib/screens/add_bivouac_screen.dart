import 'dart:typed_data';

import 'package:bivouac/components/default_appbar.dart';
import 'package:bivouac/components/default_input.dart';
import 'package:bivouac/components/mini_map.dart';
import 'package:bivouac/components/spacers.dart';
import 'package:bivouac/screens/add_pictures_screen.dart';
import 'package:bivouac/screens/select_location_screen.dart';
import 'package:bivouac/theme/color_palet.dart';
import 'package:bivouac/utils/time_maths.dart';
import 'package:calendar_timeline_sbk/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddBivouacScreen extends StatefulWidget {
  const AddBivouacScreen({super.key});

  @override
  State<AddBivouacScreen> createState() => _AddBivouacScreenState();
}

class _AddBivouacScreenState extends State<AddBivouacScreen> {

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  List<dynamic> location = [];
  String address="";

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

  List<Uint8List> images = [];

  List<String> members = [];

  void updateScreenLocation(String newAddress, List newLocation) {
    setState(() {
      address = newAddress;
      location = newLocation;
    });
  }

  void updateScreenImages(List<Uint8List> newImages) {
    setState(() {
      images = newImages;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(
        context,
        showBackButton: true,
        actions: [
          TextButton(
            onPressed: () {
              print("Add Bivouac");
            },
            child: const Text(
              "Save",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700
              ),
            ),
          )
        ]
      ),

      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [],
                ),
                verticalSpacer(10),
                Center(
                  child: SvgPicture.asset(
                    "assets/svgs/camp_night.svg",
                    height: 200,
                  ),
                ),
                verticalSpacer(20),

                TextFieldColumn(
                  controller: titleController, 
                  title: "Title", 
                  hintText: "Enter the title of the bivouac",
                ),

                verticalSpacer(20),

                TextFieldColumn(
                  controller: descriptionController, 
                  title: "Description", 
                  hintText: "Enter the description of the bivouac",
                  maxLines: 4,
                ),

                verticalSpacer(30),

                Row(
                  children: [
                    const Text(
                      "Start Date",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700
                      ),
                    ),

                    horizontalSpacer(10),

                    Text(
                      dateToString(startDate),
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[600]
                      ),
                    )
                  ],
                ),

                CalendarTimeline(
                  initialDate: startDate, 
                  firstDate: DateTime(DateTime.now().year - 2, 1, 1), 
                  lastDate: DateTime(DateTime.now().year + 2, 12, 31),
                  activeBackgroundDayColor: Colpal.darkBlue,
                  onDateSelected: (date) {
                    setState(() {
                      startDate = date;
                      if (endDate.isBefore(startDate)) endDate = startDate;
                    });
                  },
                ),


                verticalSpacer(30),

                Row(
                  children: [
                    const Text(
                      "End Date",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700
                      ),
                    ),

                    horizontalSpacer(10),

                    Text(
                      dateToString(endDate),
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[600]
                      ),
                    )
                  ],
                ),
                CalendarTimeline(
                  initialDate: endDate, 
                  firstDate: startDate, 
                  activeBackgroundDayColor: Colpal.darkBlue,
                  lastDate: DateTime(DateTime.now().year + 2, 12, 31),
                  onDateSelected: (date) {
                    setState(() {
                      endDate = date;
                    });
                  },
                ),

                verticalSpacer(30),

                ListTile(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    side: BorderSide(
                      color: Colpal.darkBlue,
                      width: 1.5
                    )
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddPicturesScreen(updateScreen: updateScreenImages, currentImages: images))
                    );
                  },
                  title: const Text(
                    "Pictures",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colpal.darkBlue
                    ),
                  ),

                  trailing: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 30,
                    color: Colpal.darkBlue,
                  ),

                  subtitle: Text(
                    images.isEmpty ? "Add pictures of the bivouac" : "Added ${images.length} pictures",
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey
                    ),
                  ),
                ),

                verticalSpacer(25),


                ListTile(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    side: BorderSide(
                      color: Colpal.darkBlue,
                      width: 1.5
                    )
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SelectLocationScreen(
                        updateScreen: updateScreenLocation,
                      ))
                    );
                  },
                  title: const Text(
                    "Location",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colpal.darkBlue
                    ),
                  ),

                  trailing: location.isEmpty ? const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 30,
                    color: Colpal.darkBlue,
                  ) : MiniMap(
                    coordinates: location, 
                    height: 100, 
                    width: 100,
                    zoom: 7,
                    openOnTap: false,
                    showMarker: false,
                  ),

                  subtitle: Text(
                    address.isEmpty ? "Add the location of the bivouac" : address,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey
                    ),
                  ),
                ),

                verticalSpacer(25),


                ListTile(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    side: BorderSide(
                      color: Colpal.darkBlue,
                      width: 1.5
                    )
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SelectLocationScreen(
                        updateScreen: updateScreenLocation,
                      ))
                    );
                  },
                  title: const Text(
                    "Members",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colpal.darkBlue
                    ),
                  ),

                  trailing: const Icon(
                    Icons.group_add,
                    size: 30,
                    color: Colpal.darkBlue,
                  ),

                  subtitle: Text(
                    members.isEmpty ? "Add members to the bivouac" : "Added ${members.length} members",
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey
                    ),
                  ),
                ),



                verticalSpacer(30),

              ],
            ),
          ),
        )
      ),
    );
  }
}