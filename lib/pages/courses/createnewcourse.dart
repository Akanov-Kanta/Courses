import 'package:flutter/material.dart';

class CreateNewCourse extends StatefulWidget {
  const CreateNewCourse({Key? key}) : super(key: key);

  @override
  State<CreateNewCourse> createState() => _CreateNewCourseState();
}

class _CreateNewCourseState extends State<CreateNewCourse> {
  @override
  Widget build(BuildContext context) {
    double screenWidth;
    double screenHeight;
    final TextEditingController _courseName = TextEditingController();
    final TextEditingController _courseTeacher = TextEditingController();
    final TextEditingController _courseCabinet = TextEditingController();
    final TextEditingController _courseAmount = TextEditingController();

    List<String> _dayweek = [
      'Понедельник',
      'Вторник',
      'Среда',
      'Четверг',
      ' Пятница',
      'Суббота',
      'Воскресенье'
    ];

    Map<String?, TextEditingController> timeList = {
      null: TextEditingController()
    };
    List<TimeTile> timeTileList = [];
    remove() {
      setState(() {
        timeTileList.removeLast();
        timeList.remove(timeList.keys.elementAt(timeList.length - 1));
      });
    }

    add() {
      print('aaaddadada');
      setState(() {
        timeList.addAll({null: TextEditingController()});
        timeTileList.add(TimeTile(
            timeList: timeList,
            options: _dayweek,
            index: timeList.length - 1,
            add: add,
            remove: remove));
      });
      print(timeList);
      print(timeTileList);
    }

    if (MediaQuery.of(context).size.width > 600) {
      screenWidth = 500;
      screenHeight = MediaQuery.of(context).size.height;
    } else {
      screenWidth = MediaQuery.of(context).size.width;
      screenHeight = MediaQuery.of(context).size.height;
    }

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        width: screenWidth,
        height: screenHeight,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white54,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5), // Shadow color
                    spreadRadius: 1, // Spread radius
                    blurRadius: 1, // Blur radius
                    offset: Offset(0, 2), // Offset in the x and y direction
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  'Создание нового курса',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'Futura',
                      fontWeight: FontWeight.w300),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    CustomInputField(
                        texting: 'Введите название курса',
                        controller: _courseName),
                    CustomInputField(
                        texting: 'Введите ФИО учителя',
                        controller: _courseTeacher),
                    CustomInputField(
                        texting: 'Введите кабинет', controller: _courseCabinet),
                    CustomInputField(
                        texting: 'Введите максимальное количество участников',
                        controller: _courseAmount),
                    Divider(
                      thickness: 2,
                    ),
                    CustomDropDown(
                      texting: 'Выберите день недели',
                      selectedOption: timeList.keys.elementAt(0),
                      options: _dayweek,
                    ),
                    CustomInputField(
                        texting: 'Введите время на день',
                        controller: timeList.values.elementAt(0)),
                    IconButton(
                        onPressed: () {
                          print('addddd');
                          add();
                        },
                        icon: Icon(Icons.add)),
                    ...timeTileList
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomInputField extends StatelessWidget {
  final String texting;
  final TextEditingController controller;

  const CustomInputField({
    Key? key,
    required this.texting,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      child: Column(
        children: [
          SizedBox(
            height: 5,
          ),
          Text(
            texting,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: 'Futura',
              fontSize: 18,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
            child: TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Заполните это поле';
                }
                return null;
              },
              controller: controller,
              decoration: InputDecoration(
                filled: true,
                fillColor: Color.fromRGBO(46, 46, 93, 0.04),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey, // Set the desired grey color here
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                labelStyle: TextStyle(
                  fontFamily: 'Futura',
                  fontWeight: FontWeight.normal,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 18,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomDropDown extends StatelessWidget {
  final String texting;
  String? selectedOption;
  final List<String> options;

  CustomDropDown({
    Key? key,
    required this.texting,
    required this.selectedOption,
    required this.options,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      child: Column(
        children: [
          SizedBox(height: 5),
          Text(
            texting,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontFamily: 'Futura', fontSize: 18),
          ),
          SizedBox(height: 8),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
            child: DropdownButtonFormField<String>(
              value: selectedOption,
              onChanged: (String? newValue) {
                selectedOption = newValue;
              },
              items: options.map<DropdownMenuItem<String>>(
                (String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                },
              ).toList(),
              decoration: InputDecoration(
                filled: true,
                fillColor: Color.fromRGBO(46, 46, 93, 0.04),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}

class TimeTile extends StatelessWidget {
  TimeTile(
      {super.key,
      required this.timeList,
      required this.options,
      required this.index,
      required this.add,
      required this.remove});
  Map<String?, TextEditingController> timeList;
  List<String> options;
  int index;
  Function() add;
  Function() remove;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(
          thickness: 2,
        ),
        CustomDropDown(
          texting: 'Выберите день недели',
          selectedOption: timeList.keys.elementAt(index),
          options: options,
        ),
        CustomInputField(
            texting: 'Введите время на день',
            controller: timeList.values.elementAt(index)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            IconButton(
                onPressed: () {
                  add();
                },
                icon: Icon(Icons.add)),
            IconButton(
                onPressed: () {
                  remove();
                },
                icon: Icon(Icons.remove)),
          ],
        ),
      ],
    );
  }
}
