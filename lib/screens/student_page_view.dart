import 'package:gurukul_beta/screens/student_quiz_page.dart';

import 's2.dart';
import 'package:flutter/material.dart';
import 'student_quiz_record.dart';
import 'package:gurukul_beta/utilities/bottomnavbar.dart';

class Student_page_view extends StatefulWidget {
  int currIndex;
  final String className;
  final String teacherEmail;
  final List<String> quizNames;
  final String subjectName;
  final String studentemail;
  final List<String> studentsemail;
  Student_page_view(
      {@required this.className,
      @required this.teacherEmail,
      @required this.subjectName,
      @required this.studentemail,
      @required this.quizNames,
      @required this.studentsemail,
      this.currIndex});
  @override
  _Student_page_viewState createState() => _Student_page_viewState();
}

class _Student_page_viewState extends State<Student_page_view> {
  PageController _pageController = new PageController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _pageController = PageController(initialPage: widget.currIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: PageView(
        physics: new NeverScrollableScrollPhysics(),
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            widget.currIndex = index;
          });
        },
        children: [
          StudentQuizPage(
            className: widget.className,
            teacherEmail: widget.teacherEmail,
            subjectName: widget.subjectName,
            studentemail: widget.studentemail,
            quizNames: widget.quizNames,
            studentsemail: widget.studentsemail,
          ),
          Student_quiz_record(
            className: widget.className,
            teacherEmail: widget.teacherEmail,
            subjectName: widget.subjectName,
            studentemail: widget.studentemail,
            quizNames: widget.quizNames,
            studentsemail: widget.studentsemail,
          ),
        ],
      ),
      bottomNavigationBar: FABBottomAppBar(
        pIndex: widget.currIndex,
        color: Colors.grey,
        backgroundColor: Colors.white,
        selectedColor: Colors.red,
        notchedShape: CircularNotchedRectangle(),
        onTabSelected: (index) {
          // print("index=$index");
          setState(() {
            widget.currIndex = index;
          });
          _pageController.animateToPage(index,
              duration: const Duration(milliseconds: 250), curve: Curves.ease);
        },
        items: [
          FABBottomAppBarItem(iconData: Icons.home, text: 'Home'),
          FABBottomAppBarItem(
              iconData: Icons.assessment_outlined, text: 'Record'),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.search),
        elevation: 2.0,
      ),
    ));
  }
}
