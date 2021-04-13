import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gurukul_beta/demo.dart';
import 'package:gurukul_beta/screens/login.dart';
// import 'demo.dart';
import 'screens/teacher_dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/student_dashboard.dart';

bool isNew = true;
void main() {
  runApp(
    HomeApp(),
  );
}

class HomeApp extends StatefulWidget {
  @override
  _HomeAppState createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  @override
  void initState() {
    // TODO: implement initState
    autoLogin();

    super.initState();
  }

  bool isLoggedIn = false;
  bool isTeacher = false;
  void autoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('emailId');
    print("hello");

    if (email != 'a' && email != null) {
      print("email.runtimeType");
      print("hello1");
      setState(() {
        isLoggedIn = true;
      });
      setState(() {
        if (prefs.getInt('radioValue') == 0) {
          isTeacher = false;
        }
      });
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    print(isLoggedIn);
    return MaterialApp(
      title: 'Flutter Tutorials',
      debugShowCheckedModeBanner: false,
      home: isLoggedIn
          ? (isTeacher ? TeacherDashBoardPage() : StudentDashBoardPage())
          : login(),
    );
    // return MaterialApp(
    //   home: Demo(),
    // );
  }
}
