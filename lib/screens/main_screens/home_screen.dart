import 'package:bivouac/components/default_buttons.dart';
import 'package:bivouac/database/auth.dart';
import 'package:bivouac/screens/add_bivouac_screen.dart';
import 'package:bivouac/screens/sign/create_user_screen.dart';
import 'package:flutter/material.dart';
import 'package:bivouac/components/app_icon.dart';
import 'package:bivouac/components/spacers.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  bool canShow=false;

  @override
  void initState() {
    super.initState();
    checkUser();
  }

  void reloadPage(){
    setState(() {
      canShow=false;
    });
    checkUser();
  }

  void checkUser() async {
    await Auth().isUserCreated().then((value) 
    {
      if (!value) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => CreateUserScreen(reloadPage: reloadPage,),));
      } else {
        setState(() {
          canShow = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!canShow) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      appIcon(width: 38),
                      horizontalSpacer(10),
                      const Text(
                        "Bivouac",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w800,
                        ),
                      ),

                      const Spacer(),

                      IconButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const AddBivouacScreen(),));
                        }, 
                        icon: const Icon(Icons.add, size: 35, color: Colors.black,),
                      )
                    ],
                  )
                ),

                const Divider(),

                verticalSpacer(5),

                bigButton("Sign out", () {
                  Auth().signOut();
                })
              ],
            ),
          ),
        ),
      )
    );
  }
}