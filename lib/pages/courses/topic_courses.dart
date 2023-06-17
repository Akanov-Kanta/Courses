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
  @override
  Widget build(BuildContext context) {
    List topicCourses = [];
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: GestureDetector(
                  onTap: () {
                    widget.changePage(1);
                  },
                  child: Container(
                    width: double.infinity,
                    child: Row(
                      children: [
                        Icon(Icons.arrow_back_ios_new_rounded),
                        Text(
                          widget.topicName,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        )
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
                    fillColor: Color.fromARGB(255, 242, 241, 247),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.all(10.0),
                  child: StreamBuilder(
                      stream: FirebaseDatabase.instance
                          .ref()
                          .child('topics/${widget.topicName}/courses')
                          .onValue,
                      builder: (BuildContext context,
                          AsyncSnapshot<DatabaseEvent> snapshot) {
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
                        topicCourses =
                              snapshot.data?.snapshot.value == null ? [] : snapshot.data?.snapshot.value as List;
                        return StreamBuilder(
                            stream: FirebaseDatabase.instance
                                .ref()
                                .child('courses')
                                .onValue,
                            builder: (context, snapshot) {
                              print('RELOAD');
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
                                final data =
                                    snapshotValue as Map<dynamic, dynamic>;
                                data.forEach((key, value) async {
                                  if (value is Map<dynamic, dynamic>) {
                                    if (topicCourses!.contains(key)) {
                                      courses.add(Course(
                                          name: key,
                                          count: value['students'] == null
                                              ? 0
                                              : (value['students'] as List)
                                                  .length,
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
                              return Wrap(
                                spacing: 10,
                                runSpacing: 10,
                                children: courses
                                    .map(
                                      (e) => TopicCourseTile(
                                        heading: e.name,
                                        count: e.count,
                                        max: e.max,
                                        cabinet: e.cabinet,
                                        teacher: e.teacher,
                                      ),
                                    )
                                    .toList(),
                              );
                            });
                      }),
                ),
              ),
            ],
          ),
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
      required this.teacher});
  final String heading;
  final int max, count;
  final String teacher;
  final String cabinet;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 2.4,
        height: 80,
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
      ),
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return CourseInfoDialog(
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
