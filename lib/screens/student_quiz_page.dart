import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gurukul_beta/utilities/bottomnavbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'student_dashboard.dart';
import 'package:gurukul_beta/utilities/classroom_details.dart';
import 'package:gurukul_beta/utilities/studentQuizPageResultData.dart';
import 'package:gurukul_beta/utilities/studentQuizTile.dart';


class QuizzesDetails {
  final String quizId, quizName;
  final int total_students;
  final int total_marks, obtained_marks;
  final int highestmarks;
  QuizzesDetails({
    @required this.quizId,
    @required this.quizName,
    @required this.obtained_marks,
    @required this.total_marks,
    @required this.total_students,
    @required this.highestmarks,
  });
}
class QuizXmarks{
  String quizName;
  dynamic marks;
  QuizXmarks({
    @required this.quizName,
    @required this.marks,
});
}
class StudentQuizPage extends StatefulWidget {
  final String className;
  final String teacherEmail;
  final List<String> quizNames;
  final String subjectName;
  final String studentemail;
  final List<String>studentsemail;
  const StudentQuizPage({@required this.className, @required this.teacherEmail, @required this.subjectName, @required this.studentemail,
      @required this.quizNames, @required this.studentsemail});

  @override
  _StudentQuizPageState createState() => _StudentQuizPageState();
}

class _StudentQuizPageState extends State<StudentQuizPage> {
  int totalQuizzes=0, classRank=0;
  double totalPercentage=0;
  final _studentQuiz = Firestore.instance;
  double screenHeight, screenWidth;
  //TODO: implement statistics page using this list
  List<QuizXmarks>quizXmarks = [];
  // final _teacherQuizName = Firestore.instance;
  // ignore: non_constant_identifier_names
  Widget QuizList(
      List<QuizzesDetails> quizList,
      ) {
    return ListView(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      children: <Widget>[
        mainScoreBoard(screenHeight: screenHeight, screenWidth: screenWidth, totalQuizzes: totalQuizzes, totalPercentage: totalPercentage, classRank: classRank),

        ListView.builder(
          padding: EdgeInsets.fromLTRB(5, 10, 5, 5),
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            QuizzesDetails _classroom = quizList[index];
            return Container(
              margin: EdgeInsets.only(
                bottom: 20,
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/tile${index % 5}.jpg'),
                  fit: BoxFit.cover,
                  colorFilter: new ColorFilter.mode(
                      Colors.black.withOpacity(0.8), BlendMode.dstATop),
                ),
                color: Colors.white,

                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.7),
                    spreadRadius:3,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  )
                ],
              ),
              padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: QuizTile(classroom: _classroom),
            );
          },
          itemCount: quizList.length,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;
    return Scaffold(
      backgroundColor: Color(0xFFF7F8FA),
      appBar: AppBar(
        backgroundColor: Color(0xFF1B8F91),
        title: Text(
          widget.className + ' ' + widget.subjectName,
          style: TextStyle(fontSize: 30.0),
        ),
      ),
      bottomNavigationBar: FABBottomAppBar(
        color: Colors.grey,
        backgroundColor: Colors.white,
        selectedColor: Colors.red,
        notchedShape: CircularNotchedRectangle(),
        //onTabSelected: _onTapped,
        items: [
          FABBottomAppBarItem(iconData: Icons.home, text: 'Home'),
          // FABBottomAppBarItem(iconData: Icons.search, text: 'ค้นหา'),
          FABBottomAppBarItem(iconData: Icons.assessment_outlined, text: 'Record'),
          // FABBottomAppBarItem(iconData: Icons.more_horiz, text: 'อื่นๆ'),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(0),
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 10, left: 5.0),
              child: ListView(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                children: <Widget>[
                  // SizedBox(height: 15),
                  Container(
                    padding: EdgeInsets.only(
                      bottom: 16,
                      // left: 16,
                      // right: 16,
                    ),
                    child: ListView(
                      physics: ClampingScrollPhysics(),
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      shrinkWrap: true,
                      children: <Widget>[
                        // classroomList(myclassroomList),
                        StreamBuilder<QuerySnapshot>(
                          stream: _studentQuiz.collection('quizDb').snapshots(),
                          builder: (context, snapshot){
                            if(!snapshot.hasData){
                              return Center(
                                child: CircularProgressIndicator(
                                  backgroundColor: Colors.green[800],
                                ),
                              );
                            }
                            final quizzesDetails = snapshot.data.documents;
                            totalQuizzes=0;
                            totalPercentage=0;
                            List<QuizzesDetails> myquizList = [
                            ];
                            Map<String, dynamic> allstudentsMarks ={};
                            // for(var names in widget.studentsemail){
                            //   allstudentsMarks = {names: 0};
                            // }
                            quizXmarks.clear();
                            for(var quizDetail in quizzesDetails)
                            {
                              print(quizDetail.data);
                              for(var quizName in widget.quizNames)
                                {
                                  print(quizName);
                                  print(widget.teacherEmail);
                                  print(widget.className);
                                  if(quizDetail.data['quiz_id']==widget.teacherEmail+'&'+quizName+'&'+widget.className)
                                    {
                                      totalQuizzes++;
                                      final int totalmarks = quizDetail.data['total_marks'];
                                      final int highestmarks = quizDetail.data['obtained_marks'];
                                      final quizid = quizDetail.data['quiz_id'];
                                      List<String> studentsemail = [];
                                      int totalstudents = 0;
                                      int obtainedmarks = 0;

                                      List<Map<String, dynamic>>studentsxMarks = [];
                                      Map<String, dynamic> mp = Map<String, dynamic>.from(quizDetail.data['students']);
                                      mp.forEach((k, v){
                                        allstudentsMarks.update(k, (dynamic val) => val+v, ifAbsent: () => v);
                                        totalstudents++;
                                        if(k==widget.studentemail){
                                          obtainedmarks = v;
                                          final mp = new QuizXmarks(quizName: quizName, marks: v);
                                          quizXmarks.add(mp);
                                        }
                                        final Map<String, dynamic> studentxmarks = {k: v};
                                        studentsxMarks.add(studentxmarks);
                                      });
                                      double percentage = (obtainedmarks*100)/totalmarks;
                                      totalPercentage += percentage;
                                      print('total percent');
                                      print(totalPercentage);
                                      final quizInfo = new QuizzesDetails(quizId: quizid, quizName: quizName, obtained_marks: obtainedmarks, total_marks: totalmarks, total_students: totalstudents, highestmarks: highestmarks);
                                      myquizList.add(quizInfo);

                                    }
                                  }
                            }
                            classRank=1;
                            allstudentsMarks.forEach((key, value) {
                              if(key!=widget.studentemail)
                                {
                                  print(value.runtimeType);
                                  print(value);
                                  double v = double.parse(value.toString());
                                  print(v);
                                  print(totalPercentage);
                                  if(v>totalPercentage){
                                    classRank = classRank+1;
                                  }
                                }
                            });
                            if(totalQuizzes!=0) {
                              totalPercentage /= totalQuizzes;
                            }
                              myquizList.sort((a, b) => b.quizName.compareTo(a.quizName));
                            quizXmarks.sort((a, b) => b.quizName.compareTo(a.quizName));
                            print(quizXmarks);
                            print(widget.studentsemail);

                            print(allstudentsMarks);
                            return QuizList(myquizList);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.search),
        elevation: 2.0,
      ),
    );
  }
}

class mainScoreBoard extends StatelessWidget {
  const mainScoreBoard({
    Key key,
    @required this.screenHeight,
    @required this.screenWidth,
    @required this.totalQuizzes,
    @required this.totalPercentage,
    @required this.classRank,
  }) : super(key: key);

  final double screenHeight;
  final double screenWidth;
  final int totalQuizzes;
  final double totalPercentage;
  final int classRank;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight*0.3,
      width: screenWidth,
      child: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                  color: Color(0xFF8CD9C0),
                ),
                width: MediaQuery.of(context).size.width,
                height: screenHeight*0.25,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    cummulativeResult(totalQuizzes: totalQuizzes.toString(), screenWidth: screenWidth, text: 'Total Quizzes',),
                    cummulativeResult(totalQuizzes: totalPercentage.toStringAsFixed(2)+'%', screenWidth: screenWidth, text: 'Current\nPercentage',),
                    cummulativeResult(totalQuizzes: classRank.toString(), screenWidth: screenWidth, text: 'Class Rank',),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: screenHeight*0.20,
            left: screenWidth*0.05,
            right: screenWidth*0.05,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.white,
              ),
              width: screenWidth*0.9,
              height: screenHeight*0.1,
            ),
          ),
        ],
      ),
    );
  }
}



