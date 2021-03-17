import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gurukul_beta/animations/fade.dart';
import 'package:gurukul_beta/screens/login.dart';
import 'add_class.dart';
import 'package:firebase_auth/firebase_auth.dart';

class classroomDetails {
  final String name;
  final String subject;

  classroomDetails({
    @required this.name,
    @required this.subject,
  });
}

class TeacherDashBoardPage extends StatefulWidget {
  @override
  _TeacherDashBoardPageState createState() => _TeacherDashBoardPageState();
}

class _TeacherDashBoardPageState extends State<TeacherDashBoardPage> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser currUser;
  String name = "User", email = "currUser.email";
  Color activeColor = Colors.black;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        currUser = user;
        email = currUser.email;
      }
    } catch (e) {
      print(e);
    }
  }

  Color inactiveColor = Colors.grey[700];
  bool dashboardMenu = true, profileMenu = false, addClassMenu = false;
  double screenHeight, screenWidth;

  List<classroomDetails> myclassroomList = [
    new classroomDetails(
      name: 'IX-B',
      subject: 'Hindi',
    ),
    new classroomDetails(
      name: 'X-B',
      subject: 'Hindi',
    ),
    new classroomDetails(
      name: 'X-B',
      subject: 'Hindi',
    ),
    new classroomDetails(
      name: 'X-B',
      subject: 'Hindi',
    ),
    new classroomDetails(
      name: 'X-B',
      subject: 'Hindi',
    ),
    new classroomDetails(
      name: 'X-B',
      subject: 'Hindi',
    ),
  ];
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
            classroomDetails _classroom = myclassroomList[index];
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
                    colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.8), BlendMode.dstATop),
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
                child: ListTile(
                  contentPadding: EdgeInsets.fromLTRB(25, 15, 25, 15),
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.watch_later_outlined,
                      ),
                    ],
                  ),
                  title: Text(
                    "${_classroom.name}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                    ),
                  ),
                  subtitle: Text(
                    "${_classroom.subject}",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 25.0,
                    ),
                  ),
                ),
              ),
            );
          },
          itemCount: myclassroomList.length,
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
                name,
                style: TextStyle(fontSize: 20.0),
              ),
              accountEmail: Text(email),
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
            ListTile(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => AddNewClass()));
              },
              leading: Icon(
                Icons.add_circle,
                color: inactiveColor,
              ),
              title: Text(
                "Add Class",
                style: TextStyle(
                  color: inactiveColor,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                _auth.signOut();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: ((BuildContext context) => login())));
              },
              child: ListTile(
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
            ),
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
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[],
                          ),
                          classroomList(myclassroomList),
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
