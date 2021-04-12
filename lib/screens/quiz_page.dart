import 'package:flutter/material.dart';
import 'package:gurukul_beta/utilities/classroom_details.dart';
import 'package:gurukul_beta/utilities/bottomnavbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'teacher_dashboard.dart';
import 'package:gurukul_beta/utilities/classroom_details.dart';
import 'package:gurukul_beta/utilities/quiz_tile.dart';
import 'package:gurukul_beta/utilities/studentQuizPageResultData.dart';
class teacherQuizDetails {
  final String quizId, quizName;
  final int total_marks, obtained_marks, total_students;

  teacherQuizDetails({
    @required this.quizId,
    @required this.quizName,
    @required this.obtained_marks,
    @required this.total_marks,
    @required this.total_students,
  });
}

class TeacherQuizPage extends StatefulWidget {
  final String class_name;
  final String teacher_email;
  final List<String> quiz_names;
  final String subject_name;
  const TeacherQuizPage(@required this.class_name, @required this.teacher_email, @required this.subject_name,
      @required this.quiz_names);

  @override
  _TeacherQuizPageState createState() => _TeacherQuizPageState();
}

class _TeacherQuizPageState extends State<TeacherQuizPage> {
  final _teacherQuiz = Firestore.instance;
  int totalQuizzes = 0;
  double highestPercentage=0;
  double meanPercentage=0;
  double screenHeight, screenWidth;
  // final _teacherQuizName = Firestore.instance;
  Widget QuizList(
    List<teacherQuizDetails> classList,
  ) {
    return ListView(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      children: <Widget>[
        ScoreBoard(screenHeight: screenHeight, screenWidth: screenWidth, totalQuizzes: totalQuizzes, highestPercentage: highestPercentage, meanPercentage: meanPercentage),
        ListView.builder(
          padding: EdgeInsets.fromLTRB(5, 10, 5, 5),
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            teacherQuizDetails _classroom = classList[index];
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
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  )
                ],
              ),
              // padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: QuizTile(classroom: _classroom),
            );
          },
          itemCount: classList.length,
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
      appBar: AppBar(
        backgroundColor: Color(0xFF1B8F91),
        title: Text(
          widget.class_name + ' ' + widget.subject_name,
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
          FABBottomAppBarItem(iconData: Icons.home, text: 'home'),
          FABBottomAppBarItem(iconData: Icons.search, text: 'search'),
          FABBottomAppBarItem(iconData: Icons.account_circle, text: 'students'),
          FABBottomAppBarItem(iconData: Icons.assessment_outlined, text: 'stats'),
        ],
      ),
      body: SafeArea(
          child: Stack(
        children: <Widget>[
          ListView(
            padding: EdgeInsets.all(0),
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60)),
                ),
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
                          StreamBuilder<QuerySnapshot>(
                            stream:
                                _teacherQuiz.collection('quizDb').snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Center(
                                  child: CircularProgressIndicator(
                                    backgroundColor: Colors.green[800],
                                  ),
                                );
                              }

                              final quizesDetails = snapshot.data.documents;
                              List<teacherQuizDetails> myquizLists = [];
                              totalQuizzes=0;
                              for (var quizesDetail in quizesDetails) {
                                // print(quizesDetail.data);
                                // print("\n");
                                for (var quizName in widget.quiz_names) {
                                  // print(quizName);
                                  // print("\n");
                                  if (quizesDetail.data['quiz_id'] == widget.teacher_email +'&' + quizName +'&' + widget.class_name) {
                                    totalQuizzes++;
                                    final quizid = quizesDetail.data['quiz_id'];
                                    final total_marks =  quizesDetail.data['total_marks'];
                                    final obtained_marks = quizesDetail.data['obtained_marks'];
                                    List<String> students_email = [];
                                    int total_students = 0;
                                    List<Map<String, dynamic>>studentsxMarks = [];
                                    Map<String, dynamic> mp = Map<String, dynamic>.from(quizesDetail.data['students']);
                                    mp.forEach((k, v){
                                      students_email.add(k);
                                      total_students++;
                                      final Map<String, dynamic> studentxmarks = {k: v};
                                      studentsxMarks.add(studentxmarks);
                                    });
                                    final quizInfo = new teacherQuizDetails(
                                        quizId: quizid,
                                        quizName: quizName,
                                        obtained_marks: obtained_marks,
                                        total_marks: total_marks,
                                        total_students: total_students);
                                        myquizLists.add(quizInfo);
                                  }
                                }
                              }
                              myquizLists.sort((a, b) => b.quizName.compareTo(a.quizName));
                              return QuizList(myquizLists);
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
        ],
      )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
        elevation: 2.0,
      ),
    );
  }
}



class ScoreBoard extends StatelessWidget {
  const ScoreBoard({
    Key key,
    @required this.screenHeight,
    @required this.screenWidth,
    @required this.totalQuizzes,
    @required this.highestPercentage,
    @required this.meanPercentage,
  }) : super(key: key);

  final double screenHeight;
  final double screenWidth;
  final int totalQuizzes;
  final double highestPercentage;
  final double meanPercentage;

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
                    cummulativeResult(totalQuizzes: highestPercentage.toStringAsFixed(2)+'%', screenWidth: screenWidth, text: 'Highest\nPercentage',),
                    cummulativeResult(totalQuizzes: meanPercentage.toStringAsFixed(2)+'%', screenWidth: screenWidth, text: 'Mean\nPercentage',),
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



