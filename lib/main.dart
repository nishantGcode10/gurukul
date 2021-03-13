import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gurukul_beta/screens/login.dart';
// import 'demo.dart';
import 'screens/teacher_dashboard.dart';
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
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'Flutter Tutorials',
      debugShowCheckedModeBanner: false,
      home: TeacherDashBoardPage(),
    );
  }
}
