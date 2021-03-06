import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gurukul_beta/services/temeProvider.dart';
//import 'demo.dart';
import 'package:gurukul_beta/screens/login.dart';

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
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: LoginScreen(),
    );
  }
}
