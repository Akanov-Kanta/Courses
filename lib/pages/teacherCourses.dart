import 'package:courses/pages/courses/topic_courses.dart';
import 'package:flutter/material.dart';
import 'package:courses/pages/schedule.dart';
import 'package:courses/pages/courses/customdialog.dart';

class teacherCourses extends StatelessWidget {
  teacherCourses({super.key});
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
                TopicTile(
                  heading: 'Олимпиадная подготовка',
                  description: '1 курс / 2 курс',
                ),
                TopicTile(
                  heading: 'Подготовка Научных проектов',
                  description: '1 курс / 2 курс',
                ),
                TopicTile(
                  heading: 'Дополнительные знания',
                  description: '1 курс / 2 курс',
                ),
                TopicTile(
                  heading: 'Искусство',
                  description: 'Кружки',
                ),
                TopicTile(
                  heading: 'Спортивные секции',
                  description: 'Секции',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TopicTile extends StatelessWidget {
  TopicTile(
      {super.key,
        required this.heading,
        required this.description,});
  String heading, description;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return CustomDialog(topicNAME: heading, count: 15,max: 20,);
              }
          );
        },
        child: SizedBox(
          width: double.infinity,
          height: 100,
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromARGB(255, 242, 241, 247),
                  border: Border.all(color: Colors.grey, width: 0.5)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    heading,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    description,
                    style: TextStyle(color: Color(0xFF4838D1), fontSize: 15),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
