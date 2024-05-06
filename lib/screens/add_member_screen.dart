import 'package:bivouac/components/db_data_stream.dart';
import 'package:bivouac/components/default_appbar.dart';
import 'package:bivouac/components/default_buttons.dart';
import 'package:bivouac/components/profile_image.dart';
import 'package:bivouac/components/spacers.dart';
import 'package:bivouac/database/auth.dart';
import 'package:flutter/material.dart';

class AddMemberScreen extends StatefulWidget {
  final void Function(List<String>) updateScreen;
  final List<String>? currentMembers;
  const AddMemberScreen({super.key, required this.updateScreen, this.currentMembers});

  @override
  State<AddMemberScreen> createState() => _AddMemberScreenState();
}

class _AddMemberScreenState extends State<AddMemberScreen> {

  TextEditingController searchController = TextEditingController();

  List<String> members = [];

  Map<String, dynamic> getUserList(Map<String, dynamic> data){
    int i=0, cpt=0;
    Map<String, dynamic> userList = {};


    while (cpt<5 && i<data.length) {
      if (data.keys.elementAt(i).toLowerCase().startsWith(searchController.text.toLowerCase()) || searchController.text==" ") {
        cpt++;
        userList[data.keys.elementAt(i)] = data.values.elementAt(i);
      }
      i++;
    }

    return userList;
  }

  @override
  void initState() {
    if (widget.currentMembers != null) {
      setState(() {
        members = widget.currentMembers!;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(context, showBackButton: true),
      bottomSheet: Padding(
        padding: const EdgeInsets.only(right: 20, left: 20, bottom: 40),
        child: bigButton(
          "Add ${members.length} members", 
          () {
            widget.updateScreen(members);
            Navigator.pop(context);
          }
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Column(
            children: [
              TextFormField(
                cursorColor: Colors.grey[700],
                onChanged: (value) {
                  setState(() {
                    searchController.text = value;
                  });
                
                },
                decoration: InputDecoration(
                  hintText: 'Search for a user',
                  hintStyle: const TextStyle(color: Colors.grey),
                  prefixIcon: const Icon(Icons.search, color: Colors.grey,),
                  fillColor: Colors.grey[300],
                  contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  filled: true,
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    borderSide: BorderSide.none
                  ),
                ),
                onTapOutside: (event) {
                  FocusScope.of(context).unfocus();
                },
              ),
        
              verticalSpacer(30),
        
              searchController.text.isEmpty ? ListView.separated(
                  shrinkWrap: true,
                  separatorBuilder: (context, index) => const Divider(
                    height: 1,
                  ),
                  itemCount: members.length,
                  itemBuilder: (context, index) {
        
                    return ListTile(
                      title: Row(
                        children: [
                          ProfileImage(
                            uid: members[index],
                            size: 20,
                          ),
                          horizontalSpacer(10),
                          DataStream(
                            collection: "users", 
                            id: members[index], 
                            builder: (data) {
                              return Text(
                                data['username'],
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600
                                ),
                              );
                            }
                          )
                        ],
                      ),
                      trailing: const Icon(Icons.check, color: Colors.green,),
                      onTap: () {
                        setState(() {
                          members.remove(members[index]);
                        });
                      },
                    );
                  },
                ) : DataStream(
                collection: "users", 
                id: "user_list", 
                builder: (usersData) {
                  Map<String, dynamic> data = getUserList(usersData);
                  return ListView.separated(
                    shrinkWrap: true,
                    separatorBuilder: (context, index) {
                      if (data.values.elementAt(index) == Auth().currentUser!.uid) {
                        return Container();
                      } 
                      return const Divider(
                        height: 1,
                      );
                    },
                    itemCount: data.length<=10 ? data.length : 10,
                    itemBuilder: (context, index) {
                      if (data.values.elementAt(index) == Auth().currentUser!.uid) {
                        return Container();
                      }
                      return ListTile(
                        title: Row(
                          children: [
                            ProfileImage(
                              uid: data.values.elementAt(index),
                              size: 20,
                            ),
                            horizontalSpacer(10),
                            Text(
                              data.keys.elementAt(index),
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600
                              ),
                            ),
                          ],
                        ),
                        trailing: members.contains(data.values.elementAt(index)) ? const Icon(Icons.check, color: Colors.green,) : const Icon(
                          Icons.add,
                          color: Colors.grey,
                        ),
                        onTap: () {
                          setState(() {
                            if (members.contains(data.values.elementAt(index))) {
                              members.remove(data.values.elementAt(index));
                            } else {
                              members.add(data.values.elementAt(index));
                            }
                          });
                        },
                      );
                    },
                  );
                }
              ),
        
              verticalSpacer(50),
              
            ],
          ),
        ),
      ),
    );
  }
}