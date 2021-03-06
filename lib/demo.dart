import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'AppNotifier.dart';

class ThemeDemo extends StatefulWidget {
  @override
  ThemeDemoState createState() => ThemeDemoState();
}

class ThemeDemoState extends State<ThemeDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Flutter Themes'),
        leading: Icon(Icons.menu),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, pos) {
            return Card(
              elevation: 0,
              child: ListTile(
                title: Text(
                  "Title $pos",
                ),
                subtitle: Text(
                  "Subtitle $pos",
                ),
                leading: Icon(
                  Icons.alarm,
                ),
                trailing: Icon(
                  Icons.chevron_right,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
