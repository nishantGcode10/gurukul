import 'package:flutter/material.dart';
import 'package:gurukul_beta/screens/quiz_page.dart';
import 'classroom_details.dart';

class dashboardTile extends StatelessWidget {
  const dashboardTile({
    Key key,
    @required classroomDetails classroom,
  })  : _classroom = classroom,
        super(key: key);

  final classroomDetails _classroom;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => TeacherQuizPage(_classroom.name,
                _classroom.teacher_email, _classroom.quiz_names)));
      },
      child: ListTile(
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
          "${_classroom.name}",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 35,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${_classroom.subject}",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 25.0,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              "Teacher: ${_classroom.teacherName}",
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
              '${_classroom.studentNumber}',
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
          ],
        ),
      ),
    );
  }
}
