import 'package:flutter/material.dart';

class cummulativeResult extends StatelessWidget {
  const cummulativeResult({
    Key key,
    @required this.totalQuizzes,
    @required this.screenWidth,
    @required this.text,
  }) : super(key: key);

  final String totalQuizzes;
  final double screenWidth;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          totalQuizzes,
          style: TextStyle(
            fontSize: screenWidth*0.1,
            color: Colors.white,
            fontWeight: FontWeight.w800,
          ),
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: screenWidth*0.04,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
