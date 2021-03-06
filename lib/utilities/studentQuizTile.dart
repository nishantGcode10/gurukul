import 'package:flutter/material.dart';
import 'package:gurukul_beta/screens/student_quiz_page.dart';

class QuizTile extends StatelessWidget {
  const QuizTile({
    Key key,
    @required QuizzesDetails classroom,
  })  : _classroom = classroom,
        super(key: key);

  final QuizzesDetails _classroom;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.fromLTRB(25, 35, 25, 20),
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.assignment,
            size: 40.0,
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
            "Result: \n ${_classroom.obtained_marks.toInt()}/${_classroom.total_marks.toInt()}",
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

          ),
          Text(
            '${_classroom.total_students}',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
