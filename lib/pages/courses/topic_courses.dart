import 'package:courses/main.dart';
import 'package:courses/pages/courses/all_topics.dart';
import 'package:courses/pages/courses/course_info_dialog.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class TopicCourses extends StatefulWidget {
  TopicCourses({super.key, required this.topicName, required this.changePage});
  final String topicName;
  void Function(int) changePage;

  @override
  State<TopicCourses> createState() => _TopicCoursesState();
}

class _TopicCoursesState extends State<TopicCourses> {
  void deleteDocument(String topicName) async {
    final databaseReference = FirebaseDatabase.instance.reference();
    DatabaseEvent TopiccourseEvent = await databaseReference
        .child('topics')
        .child(topicName)
        .child("courses")
        .once();
    List<dynamic> Topiccourses =
        TopiccourseEvent.snapshot.value as List<dynamic>;

    await databaseReference.child('topics').child(topicName).remove();

    DatabaseEvent courseEvent = await databaseReference.child('courses').once();
    Map<dynamic, dynamic> courses =
        courseEvent.snapshot.value as Map<dynamic, dynamic>;
    Topiccourses.forEach((key1) {
      courses.forEach((key, value) {
        print("$key    $key1");
        if (key1 == key) {
          print("$key    $key1");
          databaseReference.child('courses').child(key).remove();
        }
      });
    });
    widget.changePage(1);
  }

  @override
  Widget build(BuildContext context) {
    List topicCourses = [];
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: GestureDetector(
                onTap: () {
                  widget.changePage(1);
                },
                child: SizedBox(
                  width: double.infinity,
                  child: Row(
                    children: [
                      Icon(Icons.arrow_back_ios_new_rounded),
                      Expanded(
                        child: Text(
                          widget.topicName,
                          softWrap: true,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      userRole == Roles.admin
                          ? IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                deleteDocument(widget.topicName);
                                widget.changePage(1);
                              },
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Поиск курсов',
                  suffixIcon: Icon(Icons.search),
                  contentPadding: EdgeInsets.all(10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      style: BorderStyle.none,
                      width: 0,
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: StreamBuilder(
                  stream: FirebaseDatabase.instance
                      .ref()
                      .child('topics/${widget.topicName}/courses')
                      .onValue,
                  builder: (BuildContext context,
                      AsyncSnapshot<DatabaseEvent> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: Image.asset('images/PurpleBook.gif'),
                      );
                    }

                    if (snapshot.hasError) {
                      return Center(
                        child: Text("Ошибка получения данных"),
                      );
                    }
                    topicCourses = snapshot.data?.snapshot.value == null
                        ? []
                        : snapshot.data?.snapshot.value as List;
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

                          if (snapshot.hasError) {
                            return Center(
                              child: Text("Ошибка получения данных"),
                            );
                          }

                          if (!snapshot.hasData ||
                              snapshot.data?.snapshot.value == null) {
                            return Center(
                              child: Text("Нет данных"),
                            );
                          }

                          final List<Course> courses = [];

                          final dynamic snapshotValue =
                              snapshot.data!.snapshot.value!;
                          if (snapshotValue is Map<dynamic, dynamic>) {
                            final data = snapshotValue as Map<dynamic, dynamic>;
                            data.forEach((key, value) async {
                              if (value is Map<dynamic, dynamic>) {
                                if (topicCourses!.contains(key)) {
                                  int studentCount = value['users'] != null ? value['users'].length : 0;
                                  courses.add(Course(
                                      name: key,
                                      count: studentCount,
                                      max: value['max'],
                                      cabinet: value['cabinet'],
                                      teacher: value['teacher']));
                                }
                              } else {
                                print(
                                    "Неправильный тип данных для курса с ключом '$key': ${value.runtimeType}");
                              }
                            });
                          } else {
                            print(
                                "Неправильный тип данных: ${snapshotValue.runtimeType}");
                            return Center(
                              child: Text("Нет данных"),
                            );
                          }
                          return LayoutBuilder(
                            builder: (BuildContext context,
                                BoxConstraints constraints) {
                              return GridView.count(
                                physics: BouncingScrollPhysics(),
                                padding: EdgeInsets.all(10),
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                crossAxisCount:
                                    (constraints.maxWidth / 200).round(),
                                childAspectRatio: 2,
                                children: courses
                                    .map(
                                      (e) => TopicCourseTile(
                                        topicName: widget.topicName,
                                        heading: e.name,
                                        count: e.count,
                                        max: e.max,
                                        cabinet: e.cabinet,
                                        teacher: e.teacher,
                                      ),
                                    )
                                    .toList(),
                              );
                            },
                          );
                        });
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

class TopicCourseTile extends StatelessWidget {
  TopicCourseTile(
      {super.key,
      required this.heading,
      required this.count,
      required this.max,
      required this.cabinet,
      required this.teacher,
      required this.topicName});
  final String topicName;
  final String heading;
  final int max, count;
  final String teacher;
  final String cabinet;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Stack(
        alignment: AlignmentDirectional.topEnd,
        children: [
          Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(5),
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Color.fromARGB(255, 242, 241, 247),
                  border: Border.all(color: Colors.grey, width: 0.5)),
              child: Center(
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    heading,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 5,
            right: 5,
            child: SizedBox(
                height: 20,
                width: 50,
                child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: count < max
                            ? Color.fromARGB(255, 219, 251, 178)
                            : Color.fromARGB(255, 251, 195, 178)),
                    child: Center(child: Text('$count/$max')))),
          ),
        ],
      ),
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return CourseInfoDialog(
              topicName: topicName,
              topicNAME: heading,
              count: count,
              max: max,
              cabinet: cabinet,
              teacher: teacher,
            );
          },
        );
      },
    );
  }
}

class Course {
  final String name;
  final int count;
  final int max;
  final String teacher;
  final String cabinet;
  Course({
    required this.name,
    required this.count,
    required this.max,
    required this.teacher,
    required this.cabinet,
  });
}
