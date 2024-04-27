import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../components/app_icon.dart';
import '../../components/spacers.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    appIcon(width: 40),
                    horizontalSpacer(10),
                    const Text(
                      "Bivouac",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    horizontalSpacer(40)
                  ],
                ),

                verticalSpacer(20),

                SvgPicture.asset("assets/svgs/sign_in.svg", width: 300, height: 300),

              ],
            ),
          ),
        ),
      )
    );
  }
}
