import 'package:bivouac/components/default_buttons.dart';
import 'package:bivouac/components/icon_button.dart';
import 'package:bivouac/components/spacers.dart';
import 'package:bivouac/screens/sign/sign_in_screen.dart';
import 'package:bivouac/theme/color_palet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthSelectionScreen extends StatefulWidget {
  const AuthSelectionScreen({super.key});

  @override
  State<AuthSelectionScreen> createState() => _AuthSelectionScreenState();
}

class _AuthSelectionScreenState extends State<AuthSelectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     appIcon(width: 40),
                  //     horizontalSpacer(10),
                  //     const Text(
                  //       "Bivouac",
                  //       style: TextStyle(
                  //         fontSize: 30,
                  //         fontWeight: FontWeight.w800,
                  //       ),
                  //     ),
                  //     horizontalSpacer(40)
                  //   ],
                  // ),

                  verticalSpacer(40),

                  Center(
                    child: SvgPicture.asset(
                      "assets/svgs/camping.svg",
                      width: MediaQuery.of(context).size.width * 0.8,
                    ),
                  ),

                  verticalSpacer(40),

                  const Text(
                    "Welcome to Bivouac",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w900,
                    ),
                  ),

                  Text(
                    "Here, you can find the best camping spots near you and plan your next adventure. You can also share your own camping spots with the community.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[700],
                    ),
                  ),

                  verticalSpacer(20),

                  bigButton("Sign In", Colpal.brown, Colors.white, (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const SignInScreen(),));
                  }),
                  verticalSpacer(10),
                  bigButton("Register", Colpal.brown, Colpal.brown, () { }, isOutlined: true),

                  verticalSpacer(10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      svgIconButton("assets/icons/google_icon.svg", () => null),
                      horizontalSpacer(20),
                      svgIconButton("assets/icons/apple_icon.svg", () => null),
                    ],
                  )

                ],
              ),
            ),
          ),
        )
    );
  }
}
