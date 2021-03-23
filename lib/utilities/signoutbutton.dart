import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gurukul_beta/main.dart';
import 'package:gurukul_beta/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignOutButton extends StatelessWidget {
  const SignOutButton({
    Key key,
    @required FirebaseAuth auth,
    @required this.inactiveColor,
  })  : _auth = auth,
        super(key: key);

  final FirebaseAuth _auth;
  final Color inactiveColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await _auth.signOut();
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        var s = prefs.getString('emailId');
        print(s + "bsjfh");
        prefs.setString('emailId', 'a');
        print(prefs.getString('emailId'));
        print("hello3");
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: ((BuildContext context) => HomeApp())));
      },
      child: ListTile(
        leading: Icon(
          Icons.exit_to_app,
          color: inactiveColor,
        ),
        title: Text(
          "Sign Out",
          style: TextStyle(
            color: inactiveColor,
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
