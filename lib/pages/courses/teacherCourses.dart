import 'package:courses/pages/courses/topic_courses.dart';
import 'package:flutter/material.dart';
import 'package:courses/pages/schedule.dart';
import 'package:courses/pages/courses/course_info_dialog.dart';

class teacherCoursesList extends StatelessWidget {
  teacherCoursesList({super.key});
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
            child: ListView(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.all(10.0),
              children: [
                TeacherCourse(
                  heading: 'Олимпиадная подготовка',
                ),
                TeacherCourse(
                  heading: 'Подготовка Научных проектов',
                ),
                TeacherCourse(
                  heading: 'Дополнительные знания',
                ),
                TeacherCourse(
                  heading: 'Искусство',
                ),
                TeacherCourse(
                  heading: 'Спортивные секции',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TeacherCourse extends StatelessWidget {
  TeacherCourse(
      {super.key,
        required this.heading,});
  String heading;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return CourseInfoDialog(topicName: "", courseName: heading, count: 15,max: 20, cabinet: 'qqqq', teacher: 'chelovek',razdel: "",);
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
