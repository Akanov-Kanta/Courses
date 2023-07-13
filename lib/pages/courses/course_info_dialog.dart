import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:courses/pages/courses/topic_courses.dart';
import '../../const/constants.dart';
import '../../main.dart';

class CourseInfoDialog extends StatefulWidget {
  const CourseInfoDialog(
      {super.key,
      required this.courseName,
      required this.count,
      required this.max,
      required this.cabinet,
      required this.teacher,
      required this.topicName, required this.razdel});
  final String courseName;
  final String teacher;
  final String cabinet;
  final int max, count;
  final String topicName;
  final String razdel;

  @override
  State<CourseInfoDialog> createState() => _CourseInfoDialogState();
}

class _CourseInfoDialogState extends State<CourseInfoDialog> {
  Future<bool> hasDataInDocument() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      final myUid = currentUser.uid;
      final databaseReference = FirebaseDatabase.instance.reference();
      DatabaseEvent dataSnapshot =
      await databaseReference.child("users").child(myUid).child("courses").once();

      if (dataSnapshot.snapshot.value != null) {
        Map<String, dynamic> razdels = dataSnapshot.snapshot.value as Map<String, dynamic>;
        for (String key in razdels.keys) {
          print(key);
          if (key == widget.razdel) {
            print(key);
            return false;
          }
        }
        return true;
      } else {
        return true;
      }
    }
    return false;
  }

  Future<void> myMethod() async {
    bool hasData = await hasDataInDocument();
  }
  void unfollow() async{
    print("hello");
    final databaseReference = FirebaseDatabase.instance.ref();
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      final myUid = currentUser.uid;

      await databaseReference.child("users").child(myUid).child("courses").child(widget.razdel).remove();
      print(widget.courseName);
      await databaseReference.child("courses").child(widget.courseName).child("students").child(myUid).remove();

    }
  }

  void signUpForCourses() async {
    print("hello");
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      final myUid = currentUser.uid;

      addToCourses(myUid, widget.courseName);
      addToUser(myUid, myUid);
    }
  }

  void deleteCourse(String topicName, String courseName, teacherName) async {
    final databaseReference = FirebaseDatabase.instance.ref();
    DatabaseEvent courseEvent = await databaseReference
        .child('courses')
        .child(courseName)
        .child("students")
        .once();
    if (courseEvent.snapshot.value != null) {
      Map<String, dynamic> topicCourses = courseEvent.snapshot.value as Map<String, dynamic>;
      topicCourses.forEach((key1, key) {
        databaseReference.child('users').child(key1).child("courses").child(widget.razdel).remove();
      });
    } else {
      print("No data available at the specified path");
    }
    databaseReference
        .child("users")
        .orderByChild("fio")
        .equalTo(teacherName)
        .once()
        .then((DatabaseEvent snapshot) {
      if (snapshot.snapshot.value != null) {
        print(topicName);
        Map<dynamic, dynamic> data = snapshot.snapshot.value as  Map<dynamic, dynamic>;
        data.forEach((key, value) {
          databaseReference
              .child("users")
              .child(key)
              .child("courses")
              .child(courseName)
              .remove()
              .then((value) {
          }).catchError((error) {
            print("Failed to add topic to user: $error");
          });
        });
      } else {
        print("User not found!");
      }
    }).catchError((error) {
      print("Failed to retrieve user: $error");
    });
    await databaseReference.child('courses').child(courseName).remove();
    await databaseReference
        .child('topics')
        .child(widget.topicName)
        .child('courses')
        .orderByValue()
        .equalTo(widget.courseName)
        .once()
        .then((DatabaseEvent snapshot) {
      if (snapshot.snapshot.value != null) {
        List<dynamic> courses = snapshot.snapshot.value as List<dynamic>;
        courses.asMap().forEach((index, value) {
          if (value == widget.courseName) {
            // Удаляем документ по индексу
            databaseReference
                .child('topics')
                .child(widget.topicName)
                .child('courses')
                .child(index.toString())
                .remove();
          }
        });
      }
    });
  }

  void addToCourses(String userId, String courseName) {
    final databaseReference = FirebaseDatabase.instance.ref();
    databaseReference
        .child("courses")
        .child(courseName)
        .child("students")
        .child(userId)
        .set(true)
        .then((value) {
      print("User added to courses successfully!");
    }).catchError((error) {
      print("Failed to add user to courses: $error");
    });
  }

  void addToUser(String userId, String courseName) {
    final databaseReference = FirebaseDatabase.instance.ref();
    databaseReference
        .child("users")
        .child(userId)
        .child("courses")
        .child(widget.razdel=="1 курс/2 курс"?"курсы":widget.razdel)
        .set(widget.courseName)
        .then((value) {
      print("Topic added to user successfully!");
    }).catchError((error) {
      print("Failed to add topic to user: $error");
    });
  }

  void initState() {
    super.initState();
    myMethod(); // Вызываем myMethod при инициализации виджета
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.grey.shade50,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        width: 500,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: AlignmentDirectional(0, 0),
              child: Material(
                color: Colors.black12,
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                  width: 500,
                  decoration: BoxDecoration(
                    color: Colors.white54,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(0, -1),
                          child: Material(
                            color: Colors.white,
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Align(
                                  alignment: AlignmentDirectional(0, -1),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            10, 0, 0, 0),
                                        child: IconButton(
                                          hoverColor: Colors.transparent,
                                          color: Colors.transparent,
                                          icon: Icon(
                                            Icons.arrow_back_ios,
                                            color: Colors.black,
                                            size: 24,
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.all(5),
                                          child: SizedBox(
                                            width: double.infinity,
                                            child: Text(
                                              widget.courseName,
                                              softWrap: true,
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        )
                                      ), // Добавляем Spacer для занимания свободного пространства
                                      userRole == Roles.admin
                                          ? IconButton(
                                              icon: Icon(Icons.delete),
                                              onPressed: () {
                                                deleteCourse(
                                                    widget.topicName, widget.courseName, widget.teacher);
                                                Navigator.of(context).pop();
                                              },
                                            )
                                          : Container(),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          45, 20, 0, 20),
                                      child: Text(
                                        'На курс записано: ',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10, 20, 0, 20),
                                      child: SizedBox(
                                          height: 20,
                                          width: 50,
                                          child: Container(
                                              height: double.infinity,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: widget.count < widget.max
                                                      ? TransGreen
                                                      : TransRed),
                                              child: Center(
                                                  child: Text('${widget.count}/${widget.max}')))),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 180,
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Align(
                                alignment: AlignmentDirectional(-1, 0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      50, 15, 70, 0),
                                  child: Text(
                                    'Учитель: ${widget.teacher}',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              Align(
                                alignment: AlignmentDirectional(-1, 0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      50, 0, 70, 20),
                                  child: Text(
                                    'Кабинет проведения: ${widget.cabinet}',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        if(userRole == Roles.student) StreamBuilder(
                            stream: FirebaseDatabase.instance
                                .ref()
                                .child('users')
                                .child(FirebaseAuth.instance.currentUser!.uid)
                                .child('courses')
                                .onValue,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: Center(
                                    child: Image.asset('images/PurpleBook.gif'),
                                  ),
                                );
                              }
                              if (snapshot.data?.snapshot.value == null ||
                                  !(snapshot.data!.snapshot.value as Map)
                                      .values
                                      .contains(widget.courseName)) {
                                return SizedBox(
                                  height: 100,
                                  width: double.infinity,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 15),
                                    child: ElevatedButton(
                                      onPressed: () async{
                                        bool hasData = await hasDataInDocument();
                                        print(hasData);
                                        if(userRole == Roles.student && widget.count < widget.max && hasData){
                                          AwesomeDialog(
                                            context: context,
                                            dialogType: DialogType.success,
                                            animType: AnimType.bottomSlide,
                                            showCloseIcon: false,
                                            title: 'Успешно!',
                                            desc: 'Вы успешно записались на курс!!',
                                            width: 500,
                                            btnOkText: 'Хорошо',
                                            btnOkOnPress: () {
                                              Navigator.of(context).pop();
                                            },
                                          ).show();
                                          signUpForCourses();
                                        }
                                        else{
                                          AwesomeDialog(
                                            context: context,
                                            dialogType: DialogType.error,
                                            animType: AnimType.bottomSlide,
                                            showCloseIcon: false,
                                            title: widget.razdel=="circle"?"Кружок":widget.razdel=="course"?"Курс 1/2":"Секция",
                                            desc: 'Вы уже записаны на один из курсов из этого раздела',
                                            width: 500,
                                            btnOkText: 'Хорошо',
                                            btnOkOnPress: () {
                                              Navigator.of(context).pop();
                                            },
                                          ).show();
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.symmetric(horizontal: 24),
                                        backgroundColor: widget.count == widget.max
                                            ? Colors.grey
                                            : DarkPurple, // Replace with your desired button color
                                        elevation: 3,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                      ),
                                      child: Text(
                                        'Записаться',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w100,
                                          fontFamily: 'Poppins',
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }
                              else{
                                return SizedBox(
                                  height: 100,
                                  width: double.infinity,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 50.0, vertical: 15),
                                    child: ElevatedButton(
                                      onPressed: userRole == Roles.student
                                          ? () {
                                              AwesomeDialog(
                                                context: context,
                                                dialogType: DialogType.success,
                                                animType: AnimType.bottomSlide,
                                                showCloseIcon: false,
                                                title: 'Успешно!',
                                                desc:
                                                    'Вы успешно отписались от курса!!',
                                                width: 500,
                                                btnOkText: 'Хорошо',
                                                btnOkOnPress: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ).show();
                                              unfollow();

                                            }
                                          : null,
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 24),
                                        backgroundColor: RedNotTrans, // Replace with your desired button color
                                        elevation: 3,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                      child: Text(
                                        'Отписаться',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w100,
                                          fontFamily: 'Poppins',
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }
                            }),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
