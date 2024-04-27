import 'package:bivouac/components/default_buttons.dart';
import 'package:bivouac/components/default_input.dart';
import 'package:bivouac/components/icon_button.dart';
import 'package:bivouac/components/lodaing_indicator.dart';
import 'package:bivouac/components/spacers.dart';
import 'package:bivouac/database/auth.dart';
import 'package:bivouac/theme/color_palet.dart';
import 'package:bivouac/utils/validators.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

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

      try {
        await Auth().signInWithEmailAndPassword(email, password);
        Navigator.pop(context);
      } on FirebaseAuthException {
        setState(() {
          errorMesssage = "Wrong email or password";
          isLoading = false;
        });
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: defaultBackButton(context),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
          
                verticalSpacer(20),
          
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Let's Sign you in",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0
                    ),
                  ),
                ),
          
                verticalSpacer(20),
          
                Text(
                  "Welcome back, you've been missed!",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w800,
                    color: Colors.grey[600],
                    letterSpacing: 0
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
                ),
          
                const Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: null,
                      child :Text(
                        "Forgot Password ?",
                        style: TextStyle(
                          color: Colpal.grey,
                          fontSize: 16,
                          letterSpacing: 0
                          //fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                  ),
          
                verticalSpacer(20),
          
                bigButton("Sign In", () {
                  _submit();
                }),
                
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
          
                Center(
                  child: svgIconButton("assets/icons/google_icon.svg", () {
                      Auth().signInWithGoogle(context);
                    })
                )
          
              ],
            ),
          ),
        ),
      )
    );
  }
}
