import 'package:flutter/material.dart';

class CreateNewCourse extends StatefulWidget {
  const CreateNewCourse({Key? key}) : super(key: key);

  @override
  State<CreateNewCourse> createState() => _CreateNewCourseState();
}

class _CreateNewCourseState extends State<CreateNewCourse> {
  late double screenWidth;
  late double screenHeight;
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

  List<String?> timeListOptions = [null];
  List<TextEditingController> timeListControllers = [TextEditingController()];
  List<TimeTile> timeTileList = [];

  remove() {
    if (timeTileList.length > 1) {
      setState(() {
        timeTileList.removeLast();
      });
      timeListOptions.removeLast();
      timeListControllers.removeLast();
    }
  }

  add() {
    if (timeTileList.length < 7) {
      timeListOptions.add(null);
      timeListControllers.add(TextEditingController());
      setState(() {
        timeTileList.add(TimeTile(
          timeListControllers: timeListControllers,
          timeListOptions: timeListOptions,
          options: _dayweek,
          index: timeListOptions.length - 1,
        ));
      });
    }
  }

  @override
  void initState() {
    timeTileList.add(
      TimeTile(
        timeListControllers: timeListControllers,
        timeListOptions: timeListOptions,
        options: _dayweek,
        index: 0,
      ),
    );
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    timeListControllers.map((e) => e.dispose());
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              child: Row(
                children: [
                  IconButton(onPressed: (){Navigator.of(context).pop();}, icon: Icon(Icons.close)),
                  SizedBox(width: 15,),
                  Text(
                    'Создание нового курса',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 30,
                        fontFamily: 'Futura',
                        fontWeight: FontWeight.w300),
                  ),
                ],
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
                    ...timeTileList,
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
  List<String> options;
  late List<String> defaultOptions;

  CustomDropDown({
    Key? key,
    required this.texting,
    required this.selectedOption,
    required this.options,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    defaultOptions = List.from(options);
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
                print('Q');
                if(selectedOption != null) options.insert(defaultOptions.indexOf(selectedOption!), selectedOption!);
                options.remove(newValue);
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
  TimeTile({
    super.key,
    required this.timeListOptions,
    required this.timeListControllers,
    required this.options,
    required this.index,
  });
  List<String?> timeListOptions;
  List<TextEditingController> timeListControllers;
  List<String> options;
  int index;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(
          thickness: 2,
        ),
        CustomDropDown(
          texting: 'Выберите день недели',
          selectedOption: timeListOptions.elementAt(index),
          options: options,
        ),
        CustomInputField(
            texting: 'Введите время на день',
            controller: timeListControllers.elementAt(index)),
      ],
    );
  }
}
