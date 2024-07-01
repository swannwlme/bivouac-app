import 'package:bivouac/components/bivouac_list_tile.dart';
import 'package:bivouac/components/db_data_stream.dart';
import 'package:bivouac/components/profile_image.dart';
import 'package:bivouac/components/spacers.dart';
import 'package:bivouac/components/user_data_stream.dart';
import 'package:bivouac/screens/edit_profile_screen.dart';
import 'package:bivouac/theme/color_palet.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  bool showBio = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: UserStreamBuilder(builder: (data) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.person,
                        size: 30,
                      ),
                      horizontalSpacer(5),
                      Text(
                        data['username'],
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w800,
                        ),
                      ),

                      const Spacer(),

                      IconButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const EditProfileScreen(),));
                        },
                        icon: const Icon(
                          Icons.edit,
                          size: 25,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
        
                  verticalSpacer(15),
        
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const ProfileImage(size: 45, canModify: true,),
                      Column(
                        children: [
                          const Text(
                            "Bivouacs",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            data['bivouacs'].length.toString(),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  verticalSpacer(20),
        
                  const Text(
                    "Bio",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
        
                  Text(
                    data['description'],
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: showBio ? 20 : 3,
                    overflow: TextOverflow.fade,
                  ),
                  data['description'].length > 109 ? Align(
                    alignment: Alignment.bottomRight,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          showBio = !showBio;
                        });
                      },
                      child: Text(
                        showBio ? "Show less" : "Show more",
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ) : Container(),

                  verticalSpacer(20),

                  const Text(
                    "Clan",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  data['clan']==null || data['clan']=="null" ?  
                  const Text(
                    "No clan yet.",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                  : DataStream(collection: "clans", id: data['clan'], builder: (data) {
                    return Row(
                      children: [
                        Expanded(
                          child: Card(
                            elevation: 5,
                            color: Colpal.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Image.network(
                                    data['profile_image'],
                                    width: 60,
                                    height: 60,
                                  ),
                                  Column(
                                    children: [
                                      SizedBox(
                                        width: 220,
                                        child: Center(
                                          child: Text(
                                            data['name'],
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w800,
                                              letterSpacing: 0
                                            ),
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.group,
                                            size: 23,
                                            color: Colors.grey[700],
                                          ),
                                          horizontalSpacer(5),
                                          Text(
                                            "${data['members'].length.toString()} / 20",
                                            style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.grey[700],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },),

                  verticalSpacer(30),

                  const Text(
                    "Latest Bivouacs",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  // Latest Bivouacs
                  data['bivouacs'].length<=0 ? const Text(
                    "No bivouacs yet.",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ) : Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(
                        color: Colors.grey, width: 2 
                      )
                    ),
                    elevation: 0,
                    color: Colors.white,
                    child: ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      separatorBuilder: (context, index) => const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Divider(
                          height: 0,
                        ),
                      ),
                      itemCount: data['bivouacs'].length<4 ? data['bivouacs'].length : 4,
                      itemBuilder: (context, index) {
                        int nbItmes = data['bivouacs'].length<4 ? data['bivouacs'].length : 4;
                        String id = data['bivouacs'][nbItmes-index-1];
                        return bivouacListTile(id, context);
                      },
                    ),
                  )
        
                ],
              );
            }),
          )
        ),
      )
    );
  }
}