import 'package:flutter/material.dart';
class CreateNewCourse extends StatelessWidget {
  const CreateNewCourse({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth ;
    double screenHeight ;
    final TextEditingController _courseName=TextEditingController();
    final TextEditingController _courseTeacher=TextEditingController();
    final TextEditingController _courseCabinet=TextEditingController();
    final TextEditingController _courseTimeWeek=TextEditingController();
    final TextEditingController _courseAmount=TextEditingController();
    final TextEditingController _courseRazdel=TextEditingController();

    List<String> _dayweek = ['Понедельник', 'Вторник', 'Среда','Четверг',' Пятница'];
    String? _selectedOption;
    String? _selectedOption2;




    if (MediaQuery.of(context).size.width > 600) {
      screenWidth =500;
     screenHeight =MediaQuery.of(context).size.height;
    }
    else {
       screenWidth =MediaQuery.of(context).size.width;
       screenHeight =MediaQuery.of(context).size.height;
    }

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)
      ),
      child: Container(
        width: screenWidth,
        height: screenHeight,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10)
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 70,
                width: double.infinity,
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
                    style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'Futura',
                      fontWeight: FontWeight.w300
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15,),
              CustomInputField(texting: 'Введите название курса', controller: _courseName),
              CustomInputField(texting: 'Введите ФИО учителя', controller: _courseTeacher),
              CustomInputField(texting: 'Введите кабинет', controller: _courseCabinet),
              CustomInputField(texting: 'Введите максимальное количество участников', controller: _courseAmount),
              CustomInputField(texting: 'Введите время на день', controller: _courseTimeWeek),
              CustomDropDown(
                texting: 'Выберите день недели',
                selectedOption: _selectedOption,
                onChanged: (String? newValue) {
                  _selectedOption = newValue;
                  _courseTimeWeek.text = newValue ?? '';
                },
                options: _dayweek,
              ),
            ],

          ),
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
            style: TextStyle(fontFamily: 'Futura', fontSize: 18,),
          ),
          SizedBox(
            height: 8,
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(30, 0, 30, 0),
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
  final String? selectedOption;
  final ValueChanged<String?> onChanged;
  final List<String> options;

  const CustomDropDown({
    Key? key,
    required this.texting,
    required this.selectedOption,
    required this.onChanged,
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
            padding: EdgeInsetsDirectional.fromSTEB(30, 0, 30, 0),
            child: DropdownButtonFormField<String>(
              value: selectedOption,
              onChanged: onChanged,
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
