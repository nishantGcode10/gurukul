import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gurukul_beta/screens/login.dart';
class SignOutButton extends StatelessWidget {
  const SignOutButton({
    Key key,
    @required FirebaseAuth auth,
    @required this.inactiveColor,
  }) : _auth = auth, super(key: key);

  final FirebaseAuth _auth;
  final Color inactiveColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _auth.signOut();
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: ((BuildContext context) => login())));
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
