import 'package:flutter/material.dart';
class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20,),
        Center(
          child: Text(
            "SIGN UP",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          "Email",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
        ),
        SizedBox(
          height: 10,
        ),
        TextField(
          decoration: InputDecoration(
              labelText: "Example@gmail.com", border: OutlineInputBorder()),
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          "Email",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
        ),
        SizedBox(
          height: 10,
        ),
        TextField(

          decoration: InputDecoration(
              labelText: "Enter Password", border: OutlineInputBorder()),
        ),
        SizedBox(
          height: 24,
        ),
        //ElevatedButton(onPressed: () {}, child: Text("Sign Up"))
      ],
    ));
  }
}
