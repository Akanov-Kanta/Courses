import 'package:courses/pages/courses/topic_courses.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Topics extends StatefulWidget {
  Topics({super.key, required this.setPage, required this.changePage});
  void Function(Widget) setPage;
  void Function(int) changePage;

  @override
  State<Topics> createState() => _TopicsState();
}

class _TopicsState extends State<Topics> {
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
            child: StreamBuilder(
                stream: FirebaseDatabase.instance.ref().child('topics').onValue,
                builder: (context, snapshot) {
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

                  if (!snapshot.hasData ||
                      snapshot.data?.snapshot.value == null) {
                    return Center(
                      child: Text("Нет данных"),
                    );
                  }

                  List<Topic> topics = [];

                  final dynamic snapshotValue = snapshot.data!.snapshot!.value!;
                  if (snapshotValue is Map<dynamic, dynamic>) {
                    final data = snapshotValue as Map<dynamic, dynamic>;
                    data.forEach((key, value) {
                      if (value is Map<dynamic, dynamic>) {
                        topics.add(Topic(name: key, razdel: value['razdel']));
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
                    itemCount: topics.length,
                    itemBuilder: (BuildContext context, int index) {
                      final topic = topics[index];
                      return TopicTile(
                        heading: topic.name,
                        description: topic.razdel,
                        changePage: widget.changePage,
                        setPage: widget.setPage,
                      );
                    },
                  );
                }),
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
      required this.description,
      required this.setPage,
      required this.changePage});
  String heading, description;
  void Function(Widget) setPage;
  void Function(int) changePage;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: GestureDetector(
        onTap: () {
          setPage(TopicCourses(
            topicName: heading,
            changePage: changePage,
          ));
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
                    textAlign: TextAlign.center,
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

class Topic {
  String name;
  String razdel;
  Topic({required this.name, required this.razdel});
}
