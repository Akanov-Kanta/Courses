import 'package:courses/pages/courses/topic_courses.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:courses/pages/schedule.dart';
import 'package:courses/pages/courses/course_info_dialog.dart';

class teacherCoursesList extends StatefulWidget {
  teacherCoursesList({super.key});

  @override
  State<teacherCoursesList> createState() => _teacherCoursesListState();
}

class _teacherCoursesListState extends State<teacherCoursesList> {
  final currentUser = FirebaseAuth.instance.currentUser!.uid;
  

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
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
            child: FutureBuilder<DatabaseEvent>(
              future: FirebaseDatabase.instance
                  .ref()
                  .child('users')
                  .child(currentUser) // Replace currentUser with the appropriate user identifier
                  .child('courses')
                  .once(),
              builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                if (snapshot.hasData) {
                  DataSnapshot data = snapshot.data!.snapshot;
                  Map<dynamic, dynamic>? courses = data.value as Map<dynamic, dynamic>?;
                  if (courses != null) {
                    return ListView(
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.all(10.0),
                      children: courses.entries.map((entry) {
                        String heading = entry.key;
                        String value = entry.value.toString(); // Modify the value format according to your requirements
                        return TeacherCourse(
                          heading: value,
                          razdel: heading,
                        );
                      }).toList(),
                    );
                  } else {
                    return Center(child: Text('No courses available'));
                  }
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TeacherCourse extends StatelessWidget {
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

        CourseMore courseMore = CourseMore(
          heading: courseName,
          count: value['students'] != null ? value['students'].length : 0,
          max: Findcourses["max"],
          cabinet: Findcourses["cabinet"],
          teacher: Findcourses["teacher"],
          topicName: "",
          razdel: razdel,
        );

        return courseMore;
      }
    }

    throw Exception('Course not found'); // Throw an exception if the course is not found
  }
  TeacherCourse(
      {super.key,
        required this.heading,
      required this.razdel});
  String heading;
  String razdel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: GestureDetector(
        onTap: ()async {
          CourseMore result = await FindCourse(heading, razdel);
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return CourseInfoDialog(
                  topicName: "",
                  courseName: heading,
                  count: result.count,
                  max: result.max,
                  cabinet: result.cabinet,
                  teacher: result.teacher,
                  razdel: result.razdel,);
              }
          );
        },
        child: SizedBox(
          width: double.infinity,
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromARGB(255, 242, 241, 247),
                  border: Border.all(color: Colors.grey, width: 0.5)),
              child: Center(
                child: Text(
                  heading,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CourseMore{
  final String topicName;
  final String heading;
  final int max, count;
  final String teacher;
  final String cabinet;
  final String razdel;
  CourseMore({required this.heading, required this.count,
    required this.max,
    required this.cabinet,
    required this.teacher,
    required this.topicName,
    required this.razdel});
}
