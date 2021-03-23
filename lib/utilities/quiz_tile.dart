import 'package:flutter/material.dart';
import 'package:gurukul_beta/screens/quiz_page.dart';

class QuizTile extends StatelessWidget {
  const QuizTile({
    Key key,
    @required teacherQuizDetails classroom,
  })  : _classroom = classroom,
        super(key: key);

  final teacherQuizDetails _classroom;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.fromLTRB(25, 35, 25, 20),
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.people,
          ),
        ],
      ),
      title: Text(
        "${_classroom.quizName}",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 35,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20.0,
          ),
          Text(
            "result: ${_classroom.obtained_marks}/${_classroom.total_marks}",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 20.0,
              color: Colors.black,
            ),
          ),
        ],
      ),
      trailing: Column(
        children: [
          Icon(
            Icons.people,
            color: Colors.white,
          ),
          Text(
            '${_classroom.total_students}',
            style: TextStyle(color: Colors.white, fontSize: 20.0),
          ),
        ],
      ),
    );
  }
}
