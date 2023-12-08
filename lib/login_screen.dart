import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studifyy/registration_screen.dart';
import 'package:studifyy/ui_screen.dart';

import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  login(String email,String password) async{
    if (email == "" && password == "") {
      Fluttertoast.showToast(
          msg: "Please Enter required Credential!!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          fontSize: 14);
    }
    else{
      UserCredential? usercredential;
      try {
        usercredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password)
            .then((value) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const HomeScreen()));
          return null;
        });
      } on FirebaseAuthException catch (exp) {
        Fluttertoast.showToast(
            msg: "$exp",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            fontSize: 16);
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 24,left: 16,right: 16),
        child: SizedBox(
          width: 400,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: SizedBox(
                    height: 100,
                    width: 100,
                    child: Image.asset("assets/images/image1.png")),
              ),
              const Center(
                child: Text(
                  "Empowering Success: A guide by students for students",
                  style: TextStyle(fontSize: 16, fontFamily: "CustomFonts")
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              const Text(
                "Email",
                style: TextStyle(fontSize: 14),
              ),

              TextFormField(
                controller: email,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "Password",
                style: TextStyle(fontSize: 14),
              ),

              TextFormField(
                controller: password,
                obscureText: true,
                validator: (value) {
                  if (value!.length < 6) {
                    return "Password must be at least 6 characters long.";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 24,
              ),
              UiHelper.customButton(() {
                login(email.text.toString(), password.text.toString());
              }, "Login"),
              const SizedBox(height: 30,),
              Row(
                children: [
                  const Text(
                    "Don't have an Account?",
                    style: TextStyle(fontSize: 14),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const Registration()));
                      },
                      child: const Text(
                        "Sign up Now",
                        style:
                        TextStyle(fontSize: 14,fontWeight: FontWeight.w100),
                      ))
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
