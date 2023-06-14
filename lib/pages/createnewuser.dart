import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:courses/pages/courses/createnewcourse.dart';

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
    final TextEditingController _fio = TextEditingController();
    final TextEditingController _grade = TextEditingController();
    final TextEditingController _email = TextEditingController();
    final TextEditingController _password = TextEditingController();
    final String role = "";

    void sendDataToFirebase() async {
      try {
        FirebaseAuth auth = FirebaseAuth.instance;
        DatabaseReference dbRef = FirebaseDatabase.instance.ref();

        String fio = _fio.text;
        String grade = _grade.text;
        String email = _email.text;
        String password = _password.text;

        UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        String uid = userCredential.user!.uid;

        dbRef.child('users').child(uid).set({
          'fio': fio,
          'grade': grade,
          'email': email,
        });

        print('Данные успешно отправлены в Firebase.');
      } catch (e) {
        print('Ошибка отправки данных в Firebase: $e');
      }
    }

    var _currencies = [
      "Ученик",
      "Учитель",
      "Админ"
    ];

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
                        texting: 'ФИО ученика',
                        controller: _fio),
                    CustomInputField(
                        texting: 'Класс Ученика', controller: _grade),
                    CustomInputField(
                        texting: 'Email ученика',
                        controller: _email),
                    CustomInputField(
                        texting: 'Пороль ученика', controller: _password),
                    CustomDropDown(
                        texting: "Выберите роль",
                        selectedOption: _currencies[0],
                        options: _currencies),
                    IconButton(
                        onPressed: () {
                          sendDataToFirebase();
                          print("why");
                        },
                        icon: Icon(Icons.add)),
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