import 'package:courses/pages/courses/topic_courses.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class schedule extends StatefulWidget {
  @override
  _scheduleState createState() => _scheduleState();
}

class _scheduleState extends State<schedule> {
  late DateTime currentDate;

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
    String formattedDate = DateFormat('dd.MM.yyyy').format(currentDate);
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child:Container(
                  height: 48,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding:EdgeInsets.only(right:13),
                        child: IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: _goBack,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFF5F5FA),

                            border: Border(
                              right: BorderSide(width: 1, color: Color.fromRGBO(0, 0, 0, 0.2)),
                              left: BorderSide(width: 1, color: Color.fromRGBO(0, 0, 0, 0.2)),
                            )
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              Text(
                                DateFormat('EEEE').format(currentDate),
                                style: TextStyle(
                                  color: Color(0xFF2E2E5D),
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                DateFormat('dd/MM/yyyy').format(currentDate),
                                style: TextStyle(
                                  color: Color(0xFF2E2E5D),
                                  fontSize: 15,
                                ),
                              ),

                            ]
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 13),
                        child: IconButton(
                          icon: Icon(Icons.arrow_forward),
                          onPressed: _goForward,
                        ),
                      ),
                    ],
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
                    TopicTile(heading: 'Олимпиадная подготовка', description: '1 курс / 2 курс'),
                    TopicTile(heading: 'Подготовка Научных проектов', description: '1 курс / 2 курс'),
                    TopicTile(heading: 'Дополнительные знания', description: '1 курс / 2 курс'),
                    TopicTile(heading: 'Искусство', description: 'Кружки'),
                    TopicTile(heading: 'Спортивные секции', description: 'Секции'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TopicTile extends StatelessWidget {
  TopicTile({super.key, required this.heading, required this.description});
  String heading, description;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
            return TopicCourses(topicName: heading);
          }));
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
                  Text(heading, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                  SizedBox(height: 10,),
                  Text(description, style: TextStyle(color: Color(0xFF4838D1), fontSize: 15),),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
