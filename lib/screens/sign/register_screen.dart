import 'package:bivouac/components/default_buttons.dart';
import 'package:bivouac/components/default_input.dart';
import 'package:bivouac/components/icon_button.dart';
import 'package:bivouac/components/lodaing_indicator.dart';
import 'package:bivouac/components/spacers.dart';
import 'package:bivouac/theme/color_palet.dart';
import 'package:bivouac/utils/validators.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String errorMesssage = '';
  bool isLoading = false;

  Future<void> _submit() async {
    setState(() {
      errorMesssage = '';
    });
    if (_formKey.currentState!.validate()) {
      final email = emailController.text;
      final password = passwordController.text;

      setState(() {
        isLoading = true;
      });

      // try {
      //   await Auth().signInWithEmailAndPassword(email, password);
      //   Navigator.pop(context);
      // } on FirebaseAuthException {
      //   setState(() {
      //     errorMesssage = "Wrong email or password";
      //     isLoading = false;
      //   });
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: defaultBackButton(context),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [

              verticalSpacer(20),

              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Let's create your Account",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0
                  ),
                ),
              ),

              verticalSpacer(40),

              TextFieldColumn(
                controller: emailController,
                title: "Email",
                hintText: "example@bivouac.fr",
                keyboardType: TextInputType.emailAddress,
                validator: emailValidator,
                icon: Icons.email,
              ),
              verticalSpacer(30),
              TextFieldColumn(
                controller: passwordController,
                title: "Password",
                hintText: "YourPassword123",
                keyboardType: TextInputType.visiblePassword,
                isPassword: true,
                validator: passwordValidator,
                icon: Icons.fingerprint,
              ),verticalSpacer(30),
              TextFieldColumn(
                controller: passwordController,
                title: "Confirm your password",
                hintText: "YourPassword123",
                keyboardType: TextInputType.visiblePassword,
                isPassword: true,
                validator: passwordValidator,
                icon: Icons.fingerprint,
              ),

              verticalSpacer(40),

              bigButton("Sign Up", Colpal.brown, Colpal.brown, () { }, isOutlined: true),
              
              verticalSpacer(5),
              loadingIndicator(isLoading),

              if (errorMesssage.isNotEmpty) Text(
                errorMesssage,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.red,
                ),
              ) else const Text(" "),
                      
              verticalSpacer(5),

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
      )
    );
  }
}