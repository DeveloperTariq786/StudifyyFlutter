import 'package:flutter/material.dart';
import 'package:studifyy/home_screen.dart';
import 'package:studifyy/ui_screen.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Center(
        child: SizedBox(
          width: 400,
          child: Column(children: [
            UiHelper.customTextFeild(email, "Enter Email", false),
            UiHelper.customTextFeild(password, "Enter Password", false),
            const SizedBox(height: 30,),
            UiHelper.customButton(() {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const HomeScreen()));
            }, 'Login')
          ],),
        ),
      ),
    );
  }
}
