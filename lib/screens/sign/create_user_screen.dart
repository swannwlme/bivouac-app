import 'package:bivouac/components/default_appbar.dart';
import 'package:bivouac/components/default_buttons.dart';
import 'package:bivouac/components/default_input.dart';
import 'package:bivouac/components/spacers.dart';
import 'package:bivouac/database/auth.dart';
import 'package:bivouac/screens/sign/add_profile_picture.dart';
import 'package:bivouac/utils/validators.dart';
import 'package:flutter/material.dart';

class CreateUserScreen extends StatefulWidget {
  final Function reloadPage;
  const CreateUserScreen({super.key, required this.reloadPage});

  @override
  State<CreateUserScreen> createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<CreateUserScreen> {

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController locationController = TextEditingController();


  Future<void> saveData() async {
    if (formKey.currentState!.validate()) {
      await Auth().createUserFile(
        usernameController.text,
        descriptionController.text,
      );
    }
  }

  @override
  void initState() {
    descriptionController.text = "This is my description...";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            
          });
        },
        child: Scaffold(
          appBar: defaultAppBar(context),
          body: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: SafeArea(
              child: Form(
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
        
                      TextFieldColumn(
                        controller: locationController, 
                        title: "Location", 
                        hintText: "Click to enter your location...",
                        keyboardType: TextInputType.multiline,
                      ),
        
                      verticalSpacer(50),
            
                      bigButton("Continue", () {
                        if (formKey.currentState!.validate()) {
                          saveData().then((value) {
                            widget.reloadPage();
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AddProfilePictureScreen(),));
                          });
                        }
                      }),
                      
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}