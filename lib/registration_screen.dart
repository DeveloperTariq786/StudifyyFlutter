import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:studifyy/ui_screen.dart';
import 'firestore_data_fetching_class.dart';
import 'home_screen.dart';
import 'login_screen.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});
  @override
  State<StatefulWidget> createState() => RegistrationScreenState();
}

class RegistrationScreenState extends State<Registration> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  signUp(String email, String password) async {
    if (email == "" && password == "") {
      Fluttertoast.showToast(
          msg: "Please Enter required Credential!!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          fontSize: 14);
    } else {
      UserCredential? usercredential;
      try {
        usercredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password)
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
        body: Padding(
      padding: const EdgeInsets.only(top: 24, left: 16, right: 16),
      child: Center(
        child: SizedBox(
          width: 400,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              const Center(
                child: Text(
                  "Studifyy",
                  style: TextStyle(fontSize: 24,fontFamily: "CustomFonts",fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 20,
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
                height: 20,
              ),
              const DropdownFirestore(),
              const SizedBox(
                height: 20,
              ),
              UiHelper.customButton(() {
                signUp(email.text.toString(), password.text.toString());
              }, "Register"),
              const SizedBox(
                height: 20,
              ),

              Row(
                children: [
                  const Text(
                    "Already have an Account?",
                    style: TextStyle(fontSize: 14),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()));
                      },
                      child: const Text(
                        "Sign In",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w100),
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
