import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:cloud_firestore/cloud_firestore.dart';

class SalesData {
  final int quizNumber;
  final int marks;

  SalesData(this.quizNumber, this.marks);
}
_getSeriesData(List<SalesData> data) {
  List<charts.Series<SalesData, int>> series = [
    charts.Series(
        id: "marks",
        data: data,
        domainFn: (SalesData series, _) => series.quizNumber,
        measureFn: (SalesData series, _) => series.marks,
        colorFn: (SalesData series, _) =>
        charts.MaterialPalette.blue.shadeDefault)
  ];
  return series;
}
class Student_quiz_record extends StatefulWidget {
  final String className;
  final String teacherEmail;
  final List<String> quizNames;
  final String subjectName;
  final String studentemail;
  final List<String> studentsemail;
  const Student_quiz_record(
      {@required this.className,
      @required this.teacherEmail,
      @required this.subjectName,
      @required this.studentemail,
      @required this.quizNames,
      @required this.studentsemail});
  @override
  _Student_quiz_recordState createState() => _Student_quiz_recordState();
}

class _Student_quiz_recordState extends State<Student_quiz_record> {
  final _QuizRecord = Firestore.instance;
  List<SalesData> data = [];
  double screenHeight, screenWidth;

  Widget recordStats(List<SalesData> data, double height, double width){
    return Container(
      height: height*0.7,
      width: width*0.9,
      child: stats(data: data),
    );
  }
  @override

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF1B8F91),
          title: Text(
            "Record",
            style: TextStyle(fontSize: 30.0),
          ),
        ),
        body: ListView(
            physics: ClampingScrollPhysics(),
            padding: EdgeInsets.fromLTRB(10, 40,10, 0),
            shrinkWrap: true,
            children: <Widget>[
              // classroomList(myclassroomList),
              StreamBuilder<QuerySnapshot>(
                stream: _QuizRecord.collection('quizDb').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.green[800],
                      ),
                    );
                  }
                  final quizzesDetails = snapshot.data.documents;
                  data = [];
                  int b = 0;
                  for (var quizDetail in quizzesDetails) {
                    print(quizDetail.data);
                    for (var quizName in widget.quizNames) {
                      print(quizName);
                      print(widget.teacherEmail);
                      print(widget.className);
                      if (quizDetail.data['quiz_id'] ==
                          widget.teacherEmail +
                              '&' +
                              quizName +
                              '&' +
                              widget.className) {
                        final quizid = quizDetail.data['quiz_id'];

                        Map<String, dynamic> mp = Map<String, dynamic>.from(
                            quizDetail.data['students']);
                        mp.forEach((k, v) {
                          if (k == widget.studentemail) {
                            print(quizName[4]);
                            final mp = new SalesData(int.parse(quizName[4]), v);
                            data.add(mp);
                          }
                        });
                      }
                    }
                  }
                  data.sort((a,b)=>a.quizNumber.compareTo(b.quizNumber));
                  return recordStats(data, screenHeight, screenWidth);
                },
              ),
            ]),
      ),
    );
  }
}

class stats extends StatelessWidget {
  const stats({
    Key key,
    @required this.data,
  }) : super(key: key);

  final List<SalesData> data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Your Quiz-wise Performance',
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.w700,
        ),),
        Expanded(
          child: new charts.LineChart(
            _getSeriesData(data),
            animate: true,
            behaviors: [
              new charts.ChartTitle('Quiz Number',
                  behaviorPosition: charts.BehaviorPosition.bottom,
                  titleOutsideJustification:
                  charts.OutsideJustification.middleDrawArea),
              new charts.ChartTitle('Percentage',
                  behaviorPosition: charts.BehaviorPosition.start,
                  titleOutsideJustification:
                  charts.OutsideJustification.middleDrawArea),
            ],
          ),
        )
      ],
    );
  }
}
