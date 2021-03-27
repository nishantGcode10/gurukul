import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gurukul_beta/animations/fade.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'regScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'teacher_dashboard.dart';
import 'student_dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class login extends StatefulWidget {
  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
  final _formKey = GlobalKey<FormState>();
  var radioValue = -1;
  String pass;
  String email;
  bool spin = false;
  FirebaseAuth _auth = FirebaseAuth.instance;
  String errorMessage= "";
  final _user = Firestore.instance;
  bool isRadioCorrect = true;
  bool isvisible = false;
  IconData viewpass1 = CupertinoIcons.lock_open;
  bool pass1 = true;
  void _handleRadioValueChanged(var value) {
    setState(() {
      radioValue = value;
      print(radioValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    final passwordValidator = MultiValidator([
      RequiredValidator(errorText: 'password is required'),
      MinLengthValidator(8,
          errorText: 'password must be at least 8 digits long'),
      PatternValidator(r'(?=.*?[#?!@$%^&*-])',
          errorText: 'passwords must have at least one special character')
    ]);
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: spin,
        child: Container(
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
                              "Login",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.w800,
                              ),
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
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: Colors.grey[200]))),
                                        child: TextFormField(
                                          onChanged: (value) {
                                            email = value;
                                          },
                                          validator: EmailValidator(
                                              errorText:
                                                  'Enter a valid Email Address'),
                                          decoration: InputDecoration(
                                              hintText: "Email",
                                              hintStyle:
                                                  TextStyle(color: Colors.grey),
                                              border: InputBorder.none),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: Colors.grey[200]))),
                                        child: Row(
                                        children: [Expanded(
                                          child: TextFormField(
                                            obscureText: pass1,
                                            onChanged: (value) {
                                              pass = value;
                                            },
                                            validator: passwordValidator,
                                            decoration: InputDecoration(
                                                hintText: "Password",
                                                hintStyle:
                                                    TextStyle(color: Colors.grey),
                                                border: InputBorder.none),
                                          ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                if (pass1) {
                                                  viewpass1 =
                                                      CupertinoIcons.lock;
                                                  pass1 = !pass1;
                                                } else {
                                                  viewpass1 = CupertinoIcons
                                                      .lock_open;
                                                  pass1 = !pass1;
                                                }
                                              });
                                            },
                                            child: Icon(
                                              viewpass1,
                                            ),
                                          ),
                                        ]),
                                      ),
                                      Container(
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color:
                                                          Colors.grey[200]))),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Row(
                                                children: [
                                                  new Radio(
                                                      activeColor: Colors.green,
                                                      value: 0,
                                                      groupValue: radioValue,
                                                      onChanged:
                                                          _handleRadioValueChanged),
                                                  Text('Student'),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  new Radio<int>(
                                                      activeColor: Colors.green,
                                                      value: 1,
                                                      groupValue: radioValue,
                                                      onChanged:
                                                          _handleRadioValueChanged),
                                                  Text('Teacher'),
                                                ],
                                              ),
                                            ],
                                          )),
                                    ],
                                  ),
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            Visibility(
                              visible: isvisible,
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(
                                    CupertinoIcons.clear_circled,
                                    color: Colors.red,
                                  ),
                                  Container(
                                    child: Text(
                                      errorMessage,
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 15.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            FadeAnimation(
                                1.6,
                                GestureDetector(
                                  onTap: () async {
                                    if (_formKey.currentState.validate()) {
                                      setState(() {
                                        spin = true;
                                      });
                                      try {
                                        final user = await _auth
                                            .signInWithEmailAndPassword(
                                                email: email, password: pass);
                                        print(user);
                                        if (user != null) {
                                          final credentials = await _user.collection('teacher_credentials').getDocuments();
                                          for(var credential in credentials.documents)
                                            {
                                              print(credential.data['email']);
                                              if(credential.data['email']==email)
                                                {
                                                  print(credential.data['Flag']);
                                                  if(radioValue!=credential.data['Flag'])
                                                    {
                                                      setState(() {
                                                        isRadioCorrect = false;
                                                        spin=false;
                                                        errorMessage = "Please select the appropriate role";
                                                        isvisible = true;

                                                      });
                                                      print("baaaad");
                                                    }
                                                }
                                            }
                                          if(isRadioCorrect)
                                            {
                                              final SharedPreferences prefs =
                                              await SharedPreferences
                                                  .getInstance();
                                              prefs.setString('emailId', email);
                                              prefs.setInt('radio', radioValue);
                                              if (radioValue == 1) {
                                                Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (BuildContext
                                                        context) =>
                                                            TeacherDashBoardPage()));
                                              } else if (radioValue == 0) {
                                                Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (BuildContext
                                                        context) =>
                                                            StudentDashBoardPage()));
                                              }
                                            }
                                        }
                                        if(user==null)
                                          {
                                            print("error1");
                                          }
                                        setState(() {
                                          spin = false;
                                        });
                                      } catch (e) {
                                        print("error");
                                        print(e);
                                        print("\n" + e.code);
                                        setState(() {
                                          switch (e.code) {
                                            case "ERROR_INVALID_EMAIL":
                                              errorMessage = "Your email address appears to be malformed";
                                              break;
                                            case "ERROR_WRONG_PASSWORD":
                                              errorMessage = "Please enter the correct password";
                                              break;
                                            case "ERROR_USER_NOT_FOUND":
                                              errorMessage = "User with this email doesn't exist";
                                              break;
                                            case "ERROR_USER_DISABLED":
                                              errorMessage = "User with this email has been disabled";
                                              break;
                                            case "ERROR_TOO_MANY_REQUESTS":
                                              errorMessage = "Too many requests. Try again later";
                                              break;
                                            case "ERROR_OPERATION_NOT_ALLOWED":
                                              errorMessage = "Signing in with Email and Password is not enabled";
                                              break;
                                            default:
                                              errorMessage = "An undefined Error happened";
                                          }
                                        });
                                        setState(() {
                                          spin = false;
                                          isvisible = true;
                                        });
                                      }
                                    }
                                  },
                                  child: Container(
                                    height: 50,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 50),
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
                                        "Login",
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
                            FadeAnimation(
                                1.7,
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              RegScreen(),
                                          // HomePage(),
                                        ));
                                  },
                                  child: Text(
                                    "Create Account",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                )),
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
      ),
    );
  }
}
