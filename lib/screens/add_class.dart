import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gurukul_beta/animations/fade.dart';
class AddNewClass extends StatefulWidget {
  @override
  _AddNewClassState createState() => _AddNewClassState();
}

class _AddNewClassState extends State<AddNewClass> {
  final _formKey = GlobalKey<FormState>();
  double screenWidth, screenHeight;
  String classname;
  String subjectname;
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
                                onTap: (){
                                  Navigator.pop(context);
                                },
                                // onTap: () async {
                                //   if (_formKey.currentState.validate()) {
                                //     try {
                                //       final newUser = await _auth
                                //           .createUserWithEmailAndPassword(
                                //           email: email, password: pass);
                                //       if (newUser != null) {
                                //         print("registered");
                                //         Navigator.pushReplacement(
                                //             context,
                                //             MaterialPageRoute(
                                //                 builder:
                                //                     (BuildContext context) =>
                                //                     TeacherDashboardPage()));
                                //       }
                                //     } catch (e) {
                                //       _showMyDialog();
                                //     }
                                //   }
                                // },
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
