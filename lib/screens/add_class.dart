import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gurukul_beta/animations/fade.dart';
import 'teacher_dashboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class AddNewClass extends StatefulWidget {
  @override
  _AddNewClassState createState() => _AddNewClassState();
}

class _AddNewClassState extends State<AddNewClass> {
  Color activeColor = Colors.black;
  Color inactiveColor = Colors.grey[700];
  final _formKey = GlobalKey<FormState>();
  double screenWidth, screenHeight;
  String classname;
  String sectionname;
  String subjectname;
  final _firestore = Firestore.instance;
  Brightness statusIconColor = Brightness.dark;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: statusIconColor,
      ),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF1B8F91),
        title: Text("Classroom", style: TextStyle(fontSize: 30.0),),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF1B8F91) ,
              ),
              accountName: Text(name, style: TextStyle(fontSize: 20.0),),
              accountEmail: Text(email),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Color(0xFF1B8F91),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage('assets/dp.jpg')),
                  ),
                ),
              ),
            ),
            ListTile(
              onTap: (){
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => TeacherDashBoardPage()));
              },
              leading: Icon(
                Icons.message,
                color: inactiveColor,
              ),
              title: Text(
                "DashBoard",
                style: TextStyle(
                  color: inactiveColor,
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
            ListTile(
              leading: Icon(
                Icons.add_circle,
                color: activeColor,
              ),
              title: Text(
                "Add Class",
                style: TextStyle(
                  color: activeColor,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.exit_to_app,
                color: inactiveColor,
              ),
              title: Text(
                "Sign Out",
                style: TextStyle(
                  color: inactiveColor,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
              Color(0xFF1B8F91),
              Color(0xFF8CD9C0),
              Color(0xFF8CD9C0),
              Colors.white,
            ])),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 80,
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FadeAnimation(
                        1,
                        Center(
                          child: Text(
                            "Add New Class",
                            style: TextStyle(color: Colors.white, fontSize: 40),
                          ),
                        )),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(top: 10.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(60),
                          topRight: Radius.circular(60))),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(30),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 60,
                          ),
                          FadeAnimation(
                              1.4,
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                          color:
                                          Color.fromRGBO(225, 95, 27, .3),
                                          blurRadius: 10,
                                          offset: Offset(0, 4))
                                    ]
                                ),
                                child: Column(
                                  children: <Widget>[
                                    //class name
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey[200]))),
                                      child: TextFormField(
                                        obscureText: false,
                                        onChanged: (val){
                                          setState(() {
                                            classname = val;
                                          });
                                        },
                                        decoration: InputDecoration(
                                            hintText: "Class Name",
                                            hintStyle:
                                            TextStyle(color: Colors.grey),
                                            border: InputBorder.none),
                                      ),
                                    ),
                                    //section name
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey[200]))),
                                      child: TextFormField(
                                        obscureText: false,
                                        onChanged: (val){
                                          setState(() {
                                            sectionname = val;
                                          });
                                        },
                                        decoration: InputDecoration(
                                            hintText: "Section name",
                                            hintStyle:
                                            TextStyle(color: Colors.grey),
                                            border: InputBorder.none),
                                      ),
                                    ),
                                    //subject name box
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey[200]))),
                                      child: TextFormField(
                                        onChanged: (val) => subjectname = val,

                                        decoration: InputDecoration(
                                            hintText: "Subject Name",
                                            hintStyle:
                                            TextStyle(color: Colors.grey),
                                            border: InputBorder.none),
                                      ),
                                    ),

                                    //phone number box

                                  ],
                                ),
                              )),
                          SizedBox(
                            height: 40,
                          ),
                          //
                          SizedBox(
                            height: 40,
                          ),
                          FadeAnimation(
                              1.6,
                              GestureDetector(
                                onTap: ()async{
                                  await _firestore.collection('classrooms').add({
                                    'class_name': '$classname-$sectionname',
                                    'subject_name': subjectname,
                                    'teacher_name': name,
                                    'total_quizes': 0,
                                    'total_students':0,
                                    'quiz_name': [],
                                    'student_name': [],
                                  });
                                  print('class added');
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext
                                          context) =>
                                              TeacherDashBoardPage()));
                                },
                                child: Container(
                                  height: 50,
                                  margin: EdgeInsets.symmetric(horizontal: 50),
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            color: Color(0xFF8CD9C0),
                                            blurRadius: 10,
                                            offset: Offset(0, 10))
                                      ],
                                      borderRadius: BorderRadius.circular(50),
                                      color: Color(0xFF53BEB3)),
                                  child: Center(
                                    child: Text(
                                      "Add",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        fontSize: 25.0,
                                      ),
                                    ),
                                  ),
                                ),
                              )),
                          SizedBox(
                            height: 50,
                          ),
                          //
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
