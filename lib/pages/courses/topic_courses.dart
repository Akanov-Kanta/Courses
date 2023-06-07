import 'package:courses/pages/courses/all_topics.dart';
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
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      TopicCourseTile(
                        heading: 'laaodow',
                        count: 5,
                        max: 20,
                      ),
                      TopicCourseTile(
                        heading: 'laaodow',
                        count: 20,
                        max: 20,
                      ),
                      TopicCourseTile(
                        heading: 'laaodow',
                        count: 5,
                        max: 20,
                      ),
                      TopicCourseTile(
                        heading: 'laaodow',
                        count: 20,
                        max: 20,
                      ),
                      TopicCourseTile(
                        heading: 'laaodow',
                        count: 5,
                        max: 20,
                      ),
                      TopicCourseTile(
                        heading: 'laaodow',
                        count: 20,
                        max: 20,
                      ),
                      TopicCourseTile(
                        heading: 'laaodow',
                        count: 5,
                        max: 20,
                      ),
                      TopicCourseTile(
                        heading: 'laaodow',
                        count: 20,
                        max: 20,
                      ),
                      TopicCourseTile(
                        heading: 'laaodow',
                        count: 5,
                        max: 20,
                      ),
                      TopicCourseTile(
                        heading: 'laaodow',
                        count: 20,
                        max: 20,
                      ),
                      TopicCourseTile(
                        heading: 'laaodow',
                        count: 5,
                        max: 20,
                      ),
                      TopicCourseTile(
                        heading: 'laaodow',
                        count: 20,
                        max: 20,
                      ),
                      TopicCourseTile(
                        heading: 'laaodow',
                        count: 5,
                        max: 20,
                      ),
                      TopicCourseTile(
                        heading: 'laaodow',
                        count: 20,
                        max: 20,
                      ),
                      TopicCourseTile(
                        heading: 'laaodow',
                        count: 5,
                        max: 20,
                      ),
                      TopicCourseTile(
                        heading: 'laaodow',
                        count: 20,
                        max: 20,
                      ),
                      TopicCourseTile(
                        heading: 'laaodow',
                        count: 5,
                        max: 20,
                      ),
                      TopicCourseTile(
                        heading: 'laaodow',
                        count: 20,
                        max: 20,
                      ),
                      TopicCourseTile(
                        heading: 'laaodow',
                        count: 19,
                        max: 20,
                      ),
                      TopicCourseTile(
                        heading: 'laaodow',
                        count: 20,
                        max: 20,
                      ),
                    ],
                  ),
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
      required this.max});
  String heading;
  int max, count;
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
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color.fromARGB(255, 242, 241, 247),
                    border: Border.all(color: Colors.grey, width: 0.5)),
                child: Center(
                  child: Text(
                    heading,
                    style: TextStyle(fontWeight: FontWeight.bold),
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
    );
  }
}
