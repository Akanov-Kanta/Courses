import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

import '../../const/constants.dart';
import '../../main.dart';

class CourseInfoDialog extends StatelessWidget {
  const CourseInfoDialog(
      {super.key,
      required this.topicNAME,
      required this.count,
      required this.max,
      required this.cabinet,
      required this.teacher,
      required this.topicName});
  final String topicNAME;
  final String teacher;
  final String cabinet;
  final int max, count;
  final String topicName;

  void deleteDocument(String topicName, String courseName) async {
    print("hello");
    final databaseReference = FirebaseDatabase.instance.ref();
    print(topicName);
    print(courseName);
    await databaseReference.child('courses').child(courseName).remove();
    await databaseReference.child('topics').child(topicName).child('courses').child(courseName).remove();


  }
  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        width: 500,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: AlignmentDirectional(0, 0),
              child: Material(
                color: Colors.black12,
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                  width: 500,
                  decoration: BoxDecoration(
                    color: Colors.white54,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(0, -1),
                          child: Material(
                            color: Colors.white,
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Align(
                                  alignment: AlignmentDirectional(0, -1),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            10, 0, 0, 0),
                                        child: IconButton(
                                          hoverColor: Colors.transparent,
                                          color: Colors.transparent,
                                          icon: Icon(
                                            Icons.arrow_back_ios,
                                            color: Colors.black,
                                            size: 24,
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.all(5),
                                          child: SizedBox(
                                            width: double.infinity,
                                            child: Text(
                                              topicNAME,
                                              softWrap: true,
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),// Добавляем Spacer для занимания свободного пространства
                                      userRole == Roles.admin ?IconButton(
                                        icon: Icon(Icons.delete),
                                        onPressed: (){

                                          deleteDocument(topicName,topicNAME);
                                          Navigator.of(context).pop();
                                        },
                                      ):
                                      Container(),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          45, 20, 0, 20),
                                      child: Text(
                                        'На курс записано: ',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10, 20, 0, 20),
                                      child: SizedBox(
                                          height: 20,
                                          width: 50,
                                          child: Container(
                                              height: double.infinity,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: count < max
                                                      ? TransGreen
                                                      : TransRed),
                                              child: Center(
                                                  child: Text('$count/$max')))),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 180,
                          decoration: BoxDecoration(
                            color: Colors.white54,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Align(
                                alignment: AlignmentDirectional(-1, 0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      50, 15, 70, 0),
                                  child: Text(
                                    'Учитель: $teacher',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              Align(
                                alignment: AlignmentDirectional(-1, 0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      50, 0, 70, 20),
                                  child: Text(
                                    'Кабинет проведения: $cabinet',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white54,
                          ),
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(50, 0, 50, 50),
                            child: ElevatedButton(
                              onPressed: userRole == Roles.student &&
                                      count < max
                                  ? () {
                                      AwesomeDialog(
                                        context: context,
                                        dialogType: DialogType.success,
                                        animType: AnimType.bottomSlide,
                                        showCloseIcon: false,
                                        title: 'Успешно!',
                                        desc: 'Вы успешно записались на курс!!',
                                        width: 500,
                                        btnOkText: 'Хорошо',
                                        btnOkOnPress: () {
                                          Navigator.of(context).pop();
                                        },
                                      ).show();
                                    }
                                  : null,
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(horizontal: 24),
                                primary: count == max
                                    ? Colors.grey
                                    : DarkPurple, // Replace with your desired button color
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Записаться',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w100,
                                      fontFamily: 'Poppins',
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
