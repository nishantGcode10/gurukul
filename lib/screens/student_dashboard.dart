import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gurukul_beta/animations/fade.dart';
import 'package:gurukul_beta/screens/login.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'add_class.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gurukul_beta/utilities/signoutbutton.dart';
import 'package:gurukul_beta/utilities/dashboard_tile.dart';
import 'package:gurukul_beta/utilities/classroom_details.dart';

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


  Widget classroomList(
      List<classroomDetails> classList,
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
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 3,
                  )
                ],
              ),
              // padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/tile${index % 5}.jpg'),
                    fit: BoxFit.cover,
                    colorFilter: new ColorFilter.mode(
                        Colors.black.withOpacity(0.8), BlendMode.dstATop),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.7),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: dashboardTile(classroom: _classroom),
              ),
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
                              IconButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          AddNewClass()));
                                },
                                icon: Icon(
                                  Icons.add_circle_outline,
                                  color: Color(0xff1c7bfd),
                                ),
                                // onPressed: () {
                                //   Navigator.push(
                                //       context,
                                //       MaterialPageRoute(
                                //         builder: (BuildContext context) =>
                                //             AddNewClass(),
                                //       ));
                                // },
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
                                  for(var classDetail in classDetails)
                                  {
                                    for(var studentEmail in classDetail.data['student_email'])
                                    {
                                      if(studentEmail==studentDetails.email)
                                    {
                                      final classname = classDetail.data['class_name'];
                                      final subjectname = classDetail.data['subject_name'];
                                      final studentNumber = classDetail.data['total_students'];
                                      final teacherName = classDetail.data['teacher_name'];
                                      final classroominfo = new classroomDetails(name: classname, subject: subjectname, studentNumber: studentNumber, teacherName: teacherName);
                                      myclassroomList.add(classroominfo);
                                    }
                                    }
                                  }
                                  return classroomList(myclassroomList);
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
