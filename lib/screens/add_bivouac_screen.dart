import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'package:bivouac/components/default_appbar.dart';
import 'package:bivouac/components/default_input.dart';
import 'package:bivouac/components/mini_map.dart';
import 'package:bivouac/components/spacers.dart';
import 'package:bivouac/components/user_data_stream.dart';
import 'package:bivouac/database/auth.dart';
import 'package:bivouac/screens/add_member_screen.dart';
import 'package:bivouac/screens/add_pictures_screen.dart';
import 'package:bivouac/screens/saving_bivouac_screen.dart';
import 'package:bivouac/screens/select_location_screen.dart';
import 'package:bivouac/theme/color_palet.dart';
import 'package:bivouac/utils/time_maths.dart';
import 'package:calendar_timeline_sbk/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddBivouacScreen extends StatefulWidget {
  final Map<String, dynamic>? data;
  final String? id;
  const AddBivouacScreen({super.key, this.data, this.id});

  @override
  State<AddBivouacScreen> createState() => _AddBivouacScreenState();
}

class _AddBivouacScreenState extends State<AddBivouacScreen> {

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  List<dynamic> location = [];
  String address="";

  bool addClan = false;

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

  List<File> images = [];

  List<String> members = [];

  @override
  void initState() {
    if (widget.data != null) {
      getData();
    }
    super.initState();
  }

  void getData() async {
    if (widget.data != null) {
      titleController.text = widget.data!['name'];
      descriptionController.text = widget.data!['description'];
      startDate = widget.data!['start_time'].toDate();
      endDate = widget.data!['end_time'].toDate();
      location = widget.data!['location'];
      address = widget.data!['address'];
      members = widget.data!['members'];
      addClan = widget.data!['clan'];
      if (widget.data!['images'] != null) {
        List<String> imageUrls = widget.data!['images'].cast<String>();
        await downloadImages(imageUrls).then((value) {
          setState(() {
            images.addAll(value);
          });
        });
      }
    }
  }

  void updateScreenLocation(String newAddress, List newLocation) {
    setState(() {
      address = newAddress;
      location = newLocation;
    });
  }

  void updateScreenImages(List<File> newImages) {
    setState(() {
      images = newImages;
    });
  }

  void updateScreenMembers(List<String> newMembers) {
    setState(() {
      members = newMembers;
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
              print(images);
              members.insert(0, Auth().currentUser!.uid);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SavingBivouacScreen(data: {
                "name": titleController.text,
                "description": descriptionController.text,
                "author": Auth().currentUser!.uid,
                "start_time": startDate,
                "end_time": endDate,
                "location": location,
                "members": members,
                "images": images,
                "clan": addClan,
              }),));
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
                      endDate = startDate;
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
                      MaterialPageRoute(builder: (context) => AddMemberScreen(
                        updateScreen: updateScreenMembers,
                        currentMembers: members
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

                verticalSpacer(20),

                UserStreamBuilder(
                  builder: (data) {
                    return CheckboxListTile(
                      title: const Text(
                        "Add to Clan",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                      subtitle: const Text(
                        "Add this bivouac to the clan",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      value: addClan,
                      onChanged: (value) {
                        setState(() {
                          addClan = value!;
                        });
                      },
                    );
                  },
                ),

                verticalSpacer(20),

                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Confirm Deletion"),
                            content: const Text("Are you sure you want to delete this bivouac?"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  "Cancel"
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Auth().removeBivouacFromUser(widget.id!);
                                  Navigator.of(context).popUntil((route) => route.isFirst);
                                },
                                child: const Text(
                                  "Delete",
                                  style: TextStyle(
                                    color: Colors.red
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colpal.white,
                      elevation: 0
                    ),
                    child: const Text(
                      "Delete Bivouac",
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w800,
                        color: Colors.red
                      ),
                    ),
                  ),
                ),



                verticalSpacer(20),

              ],
            ),
          ),
        )
      ),
    );
  }
  
  Future<List<File>> downloadImages(List<String> imageUrls) async {
    List<File> tmpImages = [];
    for (String imageUrl in imageUrls) {
      final response = await http.get(Uri.parse(imageUrl));

      final documentDirectory = await getApplicationDocumentsDirectory();

      final file = File(join(documentDirectory.path, '${imageUrls.indexOf(imageUrl)}.png'));

      file.writeAsBytesSync(response.bodyBytes);

      tmpImages.add(file);

    }

    return tmpImages;
  }
}