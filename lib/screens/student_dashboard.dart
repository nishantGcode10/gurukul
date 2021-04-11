import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'add_class.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gurukul_beta/utilities/signoutbutton.dart';
import 'package:gurukul_beta/utilities/classroom_details.dart';
import 'package:gurukul_beta/utilities/student_classroom_list.dart';

class studentDetails{
  static String name = "User", email = "currUser.email";
  static String password, phone, roll, flag;
}


class StudentDashBoardPage extends StatefulWidget {
  @override
  _StudentDashBoardPageState createState() => _StudentDashBoardPageState();
}

class _StudentDashBoardPageState extends State<StudentDashBoardPage> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final currUserDb = Firestore.instance;
  final _userClass = Firestore.instance;
  bool spin = true;
  FirebaseUser currUser;

  Color activeColor = Colors.black;
  @override
  void initState(){
    // TODO: implement initState

    super.initState();
    getAllData();
    //getCurrentUser();
    //fetchData();
  }
  void getAllData() async{
    await getCurrentUser();
    await fetchData();
  }
  Future<void> fetchData() async {
    final credentials =
    await currUserDb.collection('teacher_credentials').getDocuments();
    for (var credential in credentials.documents) {
      if (credential.data['email'] == studentDetails.email) {
        setState(() {
          studentDetails.name = credential.data['Name'];
          studentDetails.password = credential.data['password'];
          studentDetails.roll = credential.data['Roll_No.'];
          studentDetails.flag = credential.data['Flag'];
          studentDetails.phone = credential.data['Phone'];
        });

        print(credential.data);
        break;
      }
    }
  }

  Future<void> getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        setState(() {
          currUser = user;
          studentDetails.email = currUser.email;
        });
      }
    } catch (e) {
      print(e);
    }
    //await fetchData();
  }

  Color inactiveColor = Colors.grey[700];
  bool dashboardMenu = true, profileMenu = false, addClassMenu = false;
  double screenHeight, screenWidth;


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;
    //while(name=="User");
    //fetchData();
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF1B8F91),
        title: Text(
          "Classroom",
          style: TextStyle(fontSize: 30.0),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF1B8F91),
              ),
              accountName: Text(
                studentDetails.name,
                style: TextStyle(fontSize: 20.0),
              ),
              accountEmail: Text(studentDetails.email),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF1B8F91),
                    shape: BoxShape.circle,
                    image: DecorationImage(image: AssetImage('assets/dp.jpg')),
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.message,
                color: activeColor,
              ),
              title: Text(
                "DashBoard",
                style: TextStyle(
                  color: activeColor,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.account_box_rounded,
                color: inactiveColor,
              ),
              title: Text(
                "Profile",
                style: TextStyle(
                  color: inactiveColor,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SignOutButton(auth: _auth, inactiveColor: inactiveColor),
          ],
        ),
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
                    padding: const EdgeInsets.only(
                      top: 5,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                "My Class",
                                style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // SizedBox(height: 10),
                        //
                      ],
                    ),
                  ),
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
                            left: 16,
                            right: 16,
                          ),
                          child: ListView(
                            physics: ClampingScrollPhysics(),
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            shrinkWrap: true,
                            children: <Widget>[
                              // classroomList(myclassroomList),
                              StreamBuilder<QuerySnapshot>(
                                stream: _userClass.collection('classrooms').snapshots(),
                                builder: (context, snapshot){
                                  if(!snapshot.hasData){
                                    return Center(
                                      child: CircularProgressIndicator(
                                        backgroundColor: Colors.green[800],
                                      ),
                                    );
                                  }
                                  final classDetails = snapshot.data.documents;
                                  List<classroomDetails> myclassroomList = [
                                  ];
                                  List<String>studentsemail = [];

                                  for(var classDetail in classDetails)
                                  {
                                    for(var studentEmail in classDetail.data['student_email'])
                                    {
                                      studentsemail.add(studentEmail);
                                      if(studentEmail==studentDetails.email)
                                    {
                                      final classname = classDetail.data['class_name'];
                                      final subjectname = classDetail.data['subject_name'];
                                      final studentNumber = classDetail.data['total_students'];
                                      final teacherName = classDetail.data['teacher_name'];
                                      final teacherEmail = classDetail.data['teacher_email'];
                                      List<String> quizNames = [];
                                      for (var quizname
                                      in classDetail.data['quiz_name']) {
                                        quizNames.add(quizname);
                                      }
                                      final classroominfo = new classroomDetails(name: classname,  teacher_email: teacherEmail, subject: subjectname, studentNumber: studentNumber, teacherName: teacherName, quiz_names: quizNames);

                                      myclassroomList.add(classroominfo);
                                    }
                                    }
                                  }
                                  return classroomList(studentDetails.email, myclassroomList, studentsemail);
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
    );

  }
}
