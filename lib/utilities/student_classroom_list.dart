import 'package:flutter/material.dart';
import 'classroom_details.dart';
import 'student_dashboard_tile.dart';

Widget classroomList(
    String studentemail, List<classroomDetails> classList, List<String>studentsemail,
    ) {
  return ListView(
    shrinkWrap: true,
    physics: ClampingScrollPhysics(),
    children: <Widget>[
      ListView.builder(
        padding: EdgeInsets.fromLTRB(5, 10, 5, 5),
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          classroomDetails _classroom = classList[index];
          return Container(
            margin: EdgeInsets.only(
              bottom: 20,
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/tile${index % 5}.jpg'),
                fit: BoxFit.cover,
                colorFilter: new ColorFilter.mode(
                    Colors.black.withOpacity(0.7), BlendMode.dstATop),
              ),
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.7),
                  spreadRadius: 8,
                  blurRadius: 10,
                  offset: Offset(0, 3),
                )
              ],
            ),
            // padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
            child: dashboardTile(classroom: _classroom, studentemail: studentemail,studentsemail: studentsemail,),
          );
        },
        itemCount: classList.length,
      ),
    ],
  );
}