import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'teacher_login.dart';
import 'student_login.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color(0xff1F1F1F),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AutoSizeText(
              "Choose Your Role",
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => teacher_login()));
                },
                child: Container(
                  child: AutoSizeText("Teacher"),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => student_login()));
                },
                child: Container(
                  child: AutoSizeText("Student"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
