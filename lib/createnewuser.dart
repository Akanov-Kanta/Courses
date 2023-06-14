import 'package:courses/pages/courses/createnewcourse.dart';
import 'package:flutter/material.dart';

class CreateNewUser extends StatefulWidget {
  const CreateNewUser({Key? key}) : super(key: key);

  @override
  State<CreateNewUser> createState() => _CreateNewUserState();
}

class _CreateNewUserState extends State<CreateNewUser> {



  @override
  Widget build(BuildContext context) {

  double screenWidth;
  double screenHeight;

  if (MediaQuery.of(context).size.width > 600) {
    screenWidth = 500;
    screenHeight = MediaQuery.of(context).size.height;
  } else {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
  }

    return Dialog(
      child: Container(
        width: screenWidth,
        height: 300,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
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
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.close, size: 25),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.center,
                        child: Text(
                          'Создание нового пользователя',
                          style: TextStyle(
                            fontSize: 30,
                            fontFamily: 'Futura',
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: double.infinity,
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: ElevatedButton(
                          child: Text('Создать учителя',style: TextStyle(fontSize: 25,fontFamily: 'Futura'),),
                          onPressed: () {
                            showDialog(context: context, builder: (context){
                              return CreateTeacher();
                            });
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                if (states.contains(MaterialState.hovered))
                                  return Color(0xff3EAE4D); // Зеленый цвет при наведении
                                return Colors.grey; // Используйте основной цвет кнопки
                              },
                            ),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: double.infinity,
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: ElevatedButton(
                          child: Text('Создать ученика',style: TextStyle(fontSize: 25,fontFamily: 'Futura'),),
                          onPressed: () {
                            showDialog(context: context, builder: (context){
                              return CreateStudent();
                            });
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                if (states.contains(MaterialState.hovered))
                                  return Color(0xff3EAE4D);  // Красный цвет при наведении
                                return Colors.grey; // Используйте основной цвет кнопки
                              },
                            ),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CreateTeacher extends StatefulWidget {
  const CreateTeacher({Key? key}) : super(key: key);

  @override
  State<CreateTeacher> createState() => _CreateTeacherState();
}

class _CreateTeacherState extends State<CreateTeacher> {
  TextEditingController _membershipController =TextEditingController();
  TextEditingController _nameController=TextEditingController();
  
  
  @override
  Widget build(BuildContext context) {

    double screenWidth;
    double screenHeight;

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
        height: 350,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
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
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.arrow_back_ios, size: 25),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.center,
                        child: Text(
                          'Создание нового учителя',
                          style: TextStyle(
                            fontSize: 30,
                            fontFamily: 'Futura',
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            CustomInputField(texting: 'Введите ФИО', controller: _nameController),
            CustomInputField(texting: 'Введите должность', controller: _membershipController),
            SizedBox(height: 20,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                height: 40,
                width: double.infinity,
                child: ElevatedButton(
                  child: Text('Создать',style: TextStyle(fontFamily: 'Futura',fontSize: 20,color: Colors.white),),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black, // Replace with your desired button color
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: (){
                    print('CREATED TEACHER');
                  },
                ),
              ),
            )
          ],
        ),
        
      ),
    );
  }
}
class CreateStudent extends StatefulWidget {
  const CreateStudent({Key? key}) : super(key: key);

  @override
  State<CreateStudent> createState() => _CreateStudentState();
}

class _CreateStudentState extends State<CreateStudent> {


  TextEditingController _fioController =TextEditingController();
  TextEditingController _emailControllerStudent=TextEditingController();
  TextEditingController _gradeControler=TextEditingController();
  TextEditingController _passwordControllerStudent= TextEditingController();

  @override
  Widget build(BuildContext context) {

    double screenWidth;
    double screenHeight;

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
        height: 600,
        decoration: BoxDecoration(
          color: Colors.white54,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 2),
            ),
          ],
        ),
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
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.arrow_back_ios, size: 25),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.center,
                        child: Text(
                          'Создание нового ученика',
                          style: TextStyle(
                            fontSize: 30,
                            fontFamily: 'Futura',
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            CustomInputField(texting: 'Введите ФИО', controller: _fioController),
            CustomInputField(texting: 'Введите класс ученика', controller: _gradeControler),
            CustomInputField(texting: 'Введите почту ученика', controller: _emailControllerStudent),
            CustomInputField(texting: 'Введите пароль для ученика', controller: _passwordControllerStudent),
            SizedBox(height: 20,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                height: 40,
                width: double.infinity,
                child: ElevatedButton(
                  child: Text('Создать',style: TextStyle(fontFamily: 'Futura',fontSize: 20,color: Colors.white),),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black, // Replace with your desired button color
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: (){
                    print('CREATED STUDENT');
                  },
                ),
              ),
            )

          ],

        ),
      ),
    );
  }
}
