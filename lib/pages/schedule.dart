import 'package:courses/pages/courses/topic_courses.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Schedule extends StatefulWidget {
  @override
  _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  late DateTime currentDate;
  List<String> weekdays = [
    'Понедельник',
    'Вторник',
    'Среда',
    'Четверг',
    'Пятница',
    'Суббота',
    'Воскресенье'
  ];
  @override
  void initState() {
    super.initState();
    currentDate = DateTime.now();
  }

  void _goBack() {
    setState(() {
      currentDate = currentDate.subtract(Duration(days: 1));
    });
  }

  void _goForward() {
    setState(() {
      currentDate = currentDate.add(Duration(days: 1));
    });
  }

  @override
  Widget build(BuildContext context) {
    String currentWeeekDay = weekdays[currentDate.weekday - 1];
    return Padding(
      padding: const EdgeInsets.only(top: 0, left: 15, right: 15, bottom: 15),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 13),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back_ios_new_rounded),
                    color: Color(0xFF4838D1),
                    onPressed: _goBack,
                  ),
                ),
                Flexible(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: SizedBox(
                      height: 80,
                      width: 250,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        alignment: Alignment.center,
                        child: Text(
                          currentWeeekDay,
                          style: TextStyle(
                              color: Color(0xFF4838D1),
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 13),
                  child: IconButton(
                    icon: Icon(Icons.arrow_forward_ios_rounded),
                    color: Color(0xFF4838D1),
                    onPressed: _goForward,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: StreamBuilder(
                stream: FirebaseDatabase.instance
                    .ref()
                    .child('users')
                    .child(FirebaseAuth.instance.currentUser!.uid)
                    .child('courses')
                    .onValue,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: Image.asset('images/PurpleBook.gif'),
                    );
                  }
                  List<String>? userCourses =
                      (snapshot.data?.snapshot.value as Map?)
                          ?.values
                          .cast<String>()
                          .toList();
                  return StreamBuilder(
                      stream: FirebaseDatabase.instance
                          .ref()
                          .child('courses')
                          .onValue,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: Image.asset('images/PurpleBook.gif'),
                          );
                        }
                        Map? data = snapshot.data?.snapshot.value as Map?;
                        Map userCoursesData = {};
                        userCourses?.forEach((element) {
                          userCoursesData.addAll({element: data![element]});
                        });
                        List<ScheduleTile> weekdaySchedule = [];
                        if (userCoursesData != null) {
                          userCoursesData.forEach((key, value) {
                            final val = value as Map;
                            final schedule = val['schedule'] as Map;
                            schedule.forEach((key2, value2) {
                              if (key2 == currentWeeekDay) {
                                weekdaySchedule.add(ScheduleTile(
                                    heading: key,
                                    teacher: val['teacher'],
                                    cabinet: val['cabinet'],
                                    time: value2));
                              }
                            });
                          });
                        }
                        return weekdaySchedule.isEmpty ? Center(child: Text('Нет курсов'),) : ListView(
                          physics: BouncingScrollPhysics(),
                          padding: EdgeInsets.all(10.0),
                          children: weekdaySchedule,
                        );
                      });
                }),
          ),
        ],
      ),
    );
  }
}

class ScheduleTile extends StatelessWidget {
  ScheduleTile(
      {super.key,
      required this.heading,
      required this.teacher,
      required this.cabinet,
      required this.time});
  final String heading, teacher, cabinet, time;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 5,
      ),
      child: SizedBox(
        width: double.infinity,
        child: Material(
          elevation: 4,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color.fromARGB(255, 242, 241, 247),
                border: Border.all(color: Colors.grey, width: 0.5)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 10,
                      child: SizedBox(
                        width: double.infinity,
                        child: Text(
                          heading,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: SizedBox(
                        width: double.infinity,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: SizedBox(
                        width: double.infinity,
                        child: Text(
                          cabinet,
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 10,
                      child: SizedBox(
                        width: double.infinity,
                        child: Text(
                          teacher,
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: SizedBox(
                        width: double.infinity,
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: SizedBox(
                        width: double.infinity,
                        child: Text(
                          time,
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
