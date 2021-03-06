import 'package:flutter/material.dart';
import 'package:gurukul_beta/screens/quiz_page.dart';
import 'package:gurukul_beta/screens/student_page_view.dart';
import 'classroom_details.dart';
import 'package:gurukul_beta/screens/student_quiz_page.dart';

class dashboardTile extends StatelessWidget {
  final classroomDetails classroom;
  final String studentemail;
  final List<String> studentsemail;
  const dashboardTile(
      {@required this.studentemail,
      @required this.classroom,
      @required this.studentsemail});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            //builder: (BuildContext cntext) => Student_page_view(0),
            builder: (BuildContext context) => Student_page_view(
                  className: classroom.name,
                  teacherEmail: classroom.teacher_email,
                  subjectName: classroom.subject,
                  studentemail: studentemail,
                  quizNames: classroom.quiz_names,
                  studentsemail: studentsemail,
                  currIndex: 0,
                )));
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
          "${classroom.name}",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 35,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${classroom.subject}",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 25.0,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              "Teacher: ${classroom.teacherName}",
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
              '${classroom.studentNumber}',
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
          ],
        ),
      ),
    );
  }
}
