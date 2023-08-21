import 'package:courses/pages/courses/course_info_dialog.dart';
import 'package:courses/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:courses/pages/courses/topic_courses.dart';
import 'const/constants.dart';
import 'main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

class Sidebar extends StatefulWidget {
  Sidebar({super.key, required this.changePage});
  void Function(int) changePage;
  @override
  _SidebarState createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  final currentUser = FirebaseAuth.instance.currentUser;

  Future<CourseMore> FindCourse(String courseName, String razdel) async {
    final databaseReference = FirebaseDatabase.instance.ref();
    DatabaseEvent courseEvent = await databaseReference.child('courses').once();
    Map<dynamic, dynamic> courses =
        courseEvent.snapshot.value as Map<dynamic, dynamic>;

    for (var entry in courses.entries) {
      var key = entry.key;
      var value = entry.value;

      if (courseName == key) {
        DatabaseEvent FindcourseEvent =
            await databaseReference.child('courses').child(key).once();
        Map<dynamic, dynamic> Findcourses =
            FindcourseEvent.snapshot.value as Map<dynamic, dynamic>;

        Map<String, dynamic> studentsMap = value['students'] ?? {};
        List<String> studentIds = studentsMap.entries
            .where((entry) => entry.value == true)
            .map((entry) => entry.key.toString())
            .toList();

        List<String> studentDetails = [];
        for (var studentId in studentIds) {
          DatabaseEvent studentSnapshot =
              await databaseReference.child('users').child(studentId).once();
          Map<dynamic, dynamic> studentData =
              studentSnapshot.snapshot.value as Map<dynamic, dynamic>;

          String studentName = studentData["fio"];
          studentDetails.add(studentName);
        }

        CourseMore courseMore = CourseMore(
          students: [],
          heading: courseName,
          count: studentDetails.length,
          max: Findcourses["max"],
          cabinet: Findcourses["cabinet"],
          teacher: Findcourses["teacher"],
          topicName: "",
          razdel: razdel,
        );

        return courseMore;
      }
    }

    widget.changePage(1);

    throw Exception(
        'Course not found'); // Throw an exception if the course is not found
  }

  Future<CourseMore> FindCourseTeach(String courseName, String razdel) async {
    final databaseReference = FirebaseDatabase.instance.ref();
    DatabaseEvent courseEvent = await databaseReference.child('courses').once();
    Map<dynamic, dynamic> courses =
        courseEvent.snapshot.value as Map<dynamic, dynamic>;

    for (var entry in courses.entries) {
      var key = entry.key;
      var value = entry.value;

      if (courseName == key) {
        DatabaseEvent FindcourseEvent =
            await databaseReference.child('courses').child(key).once();
        Map<dynamic, dynamic> Findcourses =
            FindcourseEvent.snapshot.value as Map<dynamic, dynamic>;

        Map<String, dynamic> studentsMap = value['students'] ?? {};
        List<String> studentIds = studentsMap.entries
            .where((entry) => entry.value == true)
            .map((entry) => entry.key.toString())
            .toList();

        List<String> studentDetails = [];
        for (var studentId in studentIds) {
          DatabaseEvent studentSnapshot =
              await databaseReference.child('users').child(studentId).once();
          Map<dynamic, dynamic> studentData =
              studentSnapshot.snapshot.value as Map<dynamic, dynamic>;

          String studentName = studentData["fio"];
          studentDetails.add(studentName);
        }

        CourseMore courseMore = CourseMore(
          students: studentDetails,
          heading: courseName,
          count: studentDetails.length,
          max: Findcourses["max"],
          cabinet: Findcourses["cabinet"],
          teacher: Findcourses["teacher"],
          topicName: "",
          razdel: razdel,
        );

        return courseMore;
      }
    }

    widget.changePage(1);

    throw Exception(
        'Course not found'); // Throw an exception if the course is not found
  }

  @override
  Widget build(BuildContext context) {
    bool isD = isDesktop(context);
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFF5F5F5),
        ),
        child: Column(
          children: [
            Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(
                      25, 17, 121, 0.1), // Задаем серый цвет фона
                  borderRadius: BorderRadius.only(
                    bottomRight:
                        Radius.circular(56), // Округляем правый нижний угол
                  ),
                ),
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top + 9,
                    bottom: 9,
                    right: 9,
                    left: 9),
                child: Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        child: Icon(
                          Icons.person,
                          color: Color(0xFF4838D1),
                          size: 40,
                        ),
                        backgroundColor: Colors.white,
                      ),
                      tileColor: Colors.black,
                    ),
                    ListTile(
                      tileColor: Colors.black,
                      title: Text(
                        FirebaseAuth.instance.currentUser!.email!,
                        style: TextStyle(
                            color: Color(0xFF2E2E5D),
                            letterSpacing: .5,
                            fontFamily: "poppins"),
                      ),
                    ),
                  ],
                )),
            SizedBox(
              height: 40,
              child: Image.asset("assets/images/nisCourses.png"),
            ),
            if (isD)
              ListTile(
                title: Text(
                  userRole == Roles.student
                      ? 'Расписание'
                      : userRole == Roles.teacher
                          ? 'Мои курсы'
                          : 'Пользователи',
                  style: TextStyle(letterSpacing: .5, fontFamily: "poppins"),
                ),
                leading: Icon(
                  userRole == Roles.student
                      ? Icons.list_rounded
                      : userRole == Roles.teacher
                          ? Icons.work_rounded
                          : Icons.people_rounded,
                  color: DarkPurple,
                ),
                onTap: () {
                  widget.changePage(0);
                },
              ),
            if (isD)
              ListTile(
                title: Text(
                  'Курсы',
                  style: TextStyle(letterSpacing: .5, fontFamily: "poppins"),
                ),
                leading: Icon(
                  Icons.my_library_books,
                  color: DarkPurple,
                ),
                onTap: () {
                  widget.changePage(1);
                },
              ),
            if (isD)
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Divider(
                    thickness: 0.5,
                    color: Colors.grey[700],
                  ),
                ),
              ),
            userRole == Roles.student
                ? SizedBox(
                    height: 165,
                    width: double.infinity,
                    child: StreamBuilder(
                        stream: FirebaseDatabase.instance
                            .ref()
                            .child('users')
                            .child(currentUser!.uid)
                            .child("courses")
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
                              child: Text("Нет курсов"),
                            );
                          }

                          List<Course> Courses = [];

                          final dynamic snapshotValue =
                              snapshot.data!.snapshot!.value!;
                          if (snapshotValue is Map<dynamic, dynamic>) {
                            final data = snapshotValue as Map<dynamic, dynamic>;
                            data.forEach((key, value) {
                              if (value is String) {
                                Courses.add(Course(title: value, razdel: key));
                              } else {
                                print(
                                    "Неправильный тип данных для раздела с ключом '$key': ${value.runtimeType}");
                              }
                            });
                          } else {
                            print(
                                "Неправильный тип данных: ${snapshotValue.runtimeType}");
                            return Center(
                              child: Text("Нет данных"),
                            );
                          }

                          return ListView.builder(
                            physics: BouncingScrollPhysics(),
                            padding: EdgeInsets.all(10.0),
                            itemCount: Courses.length,
                            itemBuilder: (BuildContext context, int index) {
                              final Course = Courses[index];
                              return ListTile(
                                title: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(Course.razdel == "Кружки"
                                        ? "Кружок: "
                                        : Course.razdel == "курсы"
                                            ? "Курс 1/2: "
                                            : "Секция: "),
                                    Expanded(
                                      child: Text(
                                        Course.title,
                                        softWrap: false,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    )
                                  ],
                                ),
                                onTap: () async {
                                  CourseMore result = await FindCourse(
                                      Course.title, Course.razdel);
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return CourseInfoDialog(
                                        students: result.students,
                                        topicName: "",
                                        courseName: Course.title,
                                        count: result.count,
                                        max: result.max,
                                        cabinet: result.cabinet,
                                        teacher: result.teacher,
                                        razdel: result.razdel,
                                      );
                                    },
                                  );
                                },
                              );
                            },
                          );
                        }),
                  )
                : Container(),
            userRole == Roles.student
                ? SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[700],
                      ),
                    ),
                  )
                : Container(),
            ListTile(
              title: Text(
                'Выход',
                style: TextStyle(letterSpacing: .5, fontFamily: "poppins"),
              ),
              leading: Icon(Icons.logout_rounded),
              onTap: () {
                FirebaseAuth.instance.signOut();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Course {
  String title;
  String razdel;
  Course({required this.title, required this.razdel});
}

class CourseMore {
  final String topicName;
  final String heading;
  final int max, count;
  final String teacher;
  final String cabinet;
  final String razdel;
  final List<String> students;
  CourseMore(
      {required this.heading,
      required this.count,
      required this.max,
      required this.cabinet,
      required this.teacher,
      required this.topicName,
      required this.razdel,
      required this.students});
}
