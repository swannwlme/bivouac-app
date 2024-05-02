import 'package:bivouac/components/default_buttons.dart';
import 'package:bivouac/components/default_input.dart';
import 'package:bivouac/components/spacers.dart';
import 'package:bivouac/components/user_data_stream.dart';
import 'package:bivouac/database/auth.dart';
import 'package:bivouac/screens/set_location_screen.dart';
import 'package:bivouac/utils/validators.dart';
import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  List<double> location = [];


  Future<void> saveData() async {
    if (formKey.currentState!.validate()) {
      await Auth().updateUserData(
        {
          "username": usernameController.text,
          "description": descriptionController.text,
          "address": locationController.text,
          "location": location
        }
      );
    }
  }

  @override
  void initState() {
    descriptionController.text = "This is my description...";
    getData();
    super.initState();
  }

  void getData() async {
    await Auth().getUserData().then((data) {
      usernameController.text = data["username"];
      descriptionController.text = data["description"];
      location.add(data["location"][0]);
      location.add(data["location"][1]);
      locationController.text = data["address"] ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit Profile",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: const Text(
                    "Enter your informations",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              
              verticalSpacer(30),
        
              TextFieldColumn(
                controller: usernameController, 
                title: "Username", 
                hintText: "John Doe",
                icon: Icons.person,
                validator: usernameValidator,
              ),
            
              verticalSpacer(30),
            
              TextFieldColumn(
                controller: descriptionController, 
                title: "Description", 
                hintText: "This is my description...",
                keyboardType: TextInputType.multiline,
                validator: descriptionValidator,
                maxLines: 3
              ),
        
              verticalSpacer(30),
        
              GestureDetector(
                child: UserStreamBuilder(
                  builder: (data) {
                    return TextFieldColumn(
                      controller: locationController, 
                      title: "Location", 
                      hintText: data['address'] ?? "Click to set your location...",
                      enabled: false,
                    );
                  },
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SetLocationScreen(location: location, locationController: locationController,)));
                },
              ),
        
              const Spacer(),
            
              bigButton("Save", () {
                if (formKey.currentState!.validate()) {
                  saveData().then((value) => Navigator.pop(context));
                }
              }),

              verticalSpacer(30)
              
            ],
          ),
        ),
      ),
    );
  }
}