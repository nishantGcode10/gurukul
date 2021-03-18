import 'package:flutter/material.dart';

class classroomDetails {
  final String name;
  final String subject;
  final String teacherName;
  final int studentNumber;
  classroomDetails({
    @required this.name,
    @required this.subject,
    @required this.studentNumber,
    @required this.teacherName,
  });
}