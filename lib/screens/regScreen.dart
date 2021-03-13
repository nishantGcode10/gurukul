import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gurukul_beta/animations/fade.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:gurukul_beta/demo.dart';
import 'teacher_dashboard.dart';
class RegScreen extends StatefulWidget {
  @override
  _RegScreenState createState() => _RegScreenState();
}

class _RegScreenState extends State<RegScreen> {
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  String pass;
  String email;
  String phone;
  String rollno;
  int radioValue = -1;
  IconData viewpass1 = CupertinoIcons.lock_open;
  IconData viewpass2 = CupertinoIcons.lock_open;
  bool pass1 = true;
  bool pass2 = true;
  void _handleRadioValueChanged(int value) {
    setState(() {
      radioValue = value;
      print(radioValue);
    });
  }
  @override
  Widget build(BuildContext context) {
    Future<void> _showMyDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            //title: Text('AlertDialog Title'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('User Already exists'),
                  Text('Try another email'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Retry'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    final phoneValidator = MultiValidator([
      RequiredValidator(errorText: 'phone number is required'),
      MinLengthValidator(1,
          errorText: 'phone number must be at least 1 digits long'),
      PatternValidator(r'(^(?:[+0]9)?[0-9]{10,12}$)',
          errorText: 'phone number is not valid')
    ]);

    final passwordValidator = MultiValidator([
      RequiredValidator(errorText: 'password is required'),
      MinLengthValidator(8,
          errorText: 'password must be at least 8 digits long'),
      PatternValidator(r'(?=.*?[#?!@$%^&*-])',
          errorText: 'passwords must have at least one special character')
    ]);

    final emailValidator = MultiValidator([
      RequiredValidator(errorText: 'email is required'),
      MinLengthValidator(1,
          errorText: 'email must be at least 1 digits long'),
      PatternValidator(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
          errorText: 'email is not valid')
    ]);

    final rollValidator = MultiValidator([
      RequiredValidator(errorText: 'roll number is required',
      ),
      MinLengthValidator(1,
          errorText: 'roll number must be at least 1 digits long'),
    ]);



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
                            "Register",
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
                                          blurRadius: 20,
                                          offset: Offset(0, 4))
                                    ]),
                                child: Column(
                                  children: <Widget>[
                                    //email box
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
                                            email = val;
                                          });
                                        },
                                        validator: emailValidator,
                                        decoration: InputDecoration(
                                            hintText: "Email",
                                            hintStyle:
                                            TextStyle(color: Colors.grey),
                                            border: InputBorder.none),
                                      ),
                                    ),
                                    //password box
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey[200]))),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: TextFormField(
                                              obscureText: pass1,
                                              onChanged: (val) => pass = val,
                                              validator: passwordValidator,
                                              decoration: InputDecoration(
                                                  hintText: "Password",
                                                  hintStyle:
                                                  TextStyle(color: Colors.grey),
                                                  border: InputBorder.none),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: (){
                                              setState(() {
                                                if(pass1)
                                                {viewpass1 = CupertinoIcons.lock;
                                                pass1 = !pass1;}else
                                                {
                                                  viewpass1 = CupertinoIcons.lock_open;
                                                  pass1 = !pass1;
                                                }
                                              });
                                            },
                                            child: Icon(
                                              viewpass1,
                                            ),
                                          ),
                                        ],
                                      ),

                                    ),
                                    //match password
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey[200]))),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: TextFormField(
                                              obscureText: pass2,
                                              validator: (val) => MatchValidator(
                                                  errorText:
                                                  'passwords do not match')
                                                  .validateMatch(val, pass),
                                              decoration: InputDecoration(
                                                  hintText: "Confirm Password",
                                                  hintStyle:
                                                  TextStyle(color: Colors.grey),
                                                  border: InputBorder.none),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: (){
                                              setState(() {
                                                if(pass2)
                                                  {viewpass2 = CupertinoIcons.lock;
                                                pass2 = !pass2;}else
                                                  {
                                                    viewpass2 = CupertinoIcons.lock_open;
                                                    pass2 = !pass2;
                                                  }
                                              });
                                            },
                                            child: Icon(
                                              viewpass2,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    //phone number box
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey[200]))),
                                      child: TextFormField(
                                        obscureText: false,
                                        onChanged: (val) => phone = val,
                                        validator: phoneValidator,
                                        decoration: InputDecoration(
                                            hintText: "+9876543210",
                                            hintStyle:
                                            TextStyle(color: Colors.grey),
                                            border: InputBorder.none),
                                      ),
                                    ),
                                    //role
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey[200]))),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Row(
                                            children: [
                                              new Radio(
                                                  activeColor: Colors.green,
                                                  value: 0,
                                                  groupValue: radioValue,
                                                  onChanged: _handleRadioValueChanged),
                                              Text('Student'),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              new Radio<int>(
                                                  activeColor: Colors.green,
                                                  value: 1,
                                                  groupValue: radioValue,
                                                  onChanged: _handleRadioValueChanged),
                                              Text('Teacher'),
                                            ],
                                          ),
                                        ],
                                      )
                                    ),
                                    //roll number
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey[200]))),
                                      child: TextFormField(
                                        obscureText: false,
                                        onChanged: (val) => rollno = val,
                                        validator: rollValidator,
                                        decoration: InputDecoration(
                                            hintText: "Roll number",
                                            hintStyle:
                                            TextStyle(color: Colors.grey),
                                            border: InputBorder.none),
                                      ),
                                    ),
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
                                onTap: () async {
                                  if (_formKey.currentState.validate()) {
                                    try {
                                      final newUser = await _auth
                                          .createUserWithEmailAndPassword(
                                              email: email, password: pass);
                                      if (newUser != null) {
                                        print("registered");
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        TeacherDashBoardPage()));
                                      }
                                    } catch (e) {
                                      _showMyDialog();
                                    }
                                  }
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
                                      "Register",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
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
