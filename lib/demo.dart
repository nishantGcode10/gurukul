import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'utilities/bottomNavBar.dart';

class Demo extends StatefulWidget {
  @override
  _DemoState createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  Firestore _firestore = Firestore.instance;
  void _onTapped(int index) async {
    await _firestore.collection('classrooms').add({});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: FABBottomAppBar(
        color: Colors.black,
        backgroundColor: Colors.white,
        selectedColor: Color(0xFF1B8F91),
        notchedShape: CircularNotchedRectangle(),
        onTabSelected: _onTapped,
        items: [
          FABBottomAppBarItem(iconData: Icons.assessment, text: 'Stats'),
          FABBottomAppBarItem(iconData: Icons.search, text: 'Search'),
          FABBottomAppBarItem(
              iconData: Icons.people_alt_outlined, text: 'Students'),
          FABBottomAppBarItem(iconData: Icons.more_horiz, text: ''),
        ],
      ),
      body: Center(
        child: Text("bhangBhomsda"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF1B8F91),
        onPressed: () {},
        child: Icon(Icons.add),
        elevation: 2.0,
      ),
    );
  }
}
