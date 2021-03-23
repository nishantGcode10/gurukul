import 'package:flutter/material.dart';

class classroomDetails {
  final String name;
  final String subject;
  final String teacherName;
  final int studentNumber;
  final String teacher_email;
  final List<String> quiz_names;
  classroomDetails({
    @required this.name,
    @required this.subject,
    @required this.studentNumber,
    @required this.teacherName,
    @required this.quiz_names,
    @required this.teacher_email,
  });
}
