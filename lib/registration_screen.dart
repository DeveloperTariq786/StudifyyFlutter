import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:studifyy/example_file.dart';
import 'package:studifyy/ui_screen.dart';
import 'home_screen.dart';

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
      child: SizedBox(
        width: 400,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Center(
              child: Text(
                "SIGN UP",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Email",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
            ),
            const SizedBox(
              height: 10,
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
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
            ),
            const SizedBox(
              height: 10,
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
              signUp(email.text.toString(), password.text.toString());
            }, "Register")
          ],
        ),
      ),
    ));
  }
}
