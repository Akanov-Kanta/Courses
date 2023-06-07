import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:courses/const/constants.dart';
import 'package:courses/pages/courses/customdialog.dart';
import 'package:flutter/material.dart';
class EntryPage extends StatelessWidget {
  const EntryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.black,
        ),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                flex: 10,
                  child:
              Align(
                alignment: AlignmentDirectional(0,0),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 40, 20, 0),
                  child: Material(
                    color: Colors.white54,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Container(
                      width: 350,
                      height: 350,
                      decoration: BoxDecoration(
                        color: Colors.white54,
                        borderRadius: BorderRadius.circular(10)
                        ),
                      child: IntrinsicHeight(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Align(
                              alignment: AlignmentDirectional(0,-1),
                              child: Material(
                                color: Colors.white,
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Align(
                                      alignment: AlignmentDirectional(0,-1),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Padding(padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
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
                                          Padding(padding: EdgeInsetsDirectional.
                                          fromSTEB(30, 0, 0, 0),
                                          child: Text('ОП по Географии',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold
                                          ),),
                                          )
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Align(
                                          alignment: AlignmentDirectional(0,0),
                                          child: Padding(
                                            padding: EdgeInsetsDirectional.
                                            fromSTEB(60, 20, 0, 20),
                                            child: Text('На курс записано: ',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 18
                                            ),),
                                          ),
                                        ),
                                        Align(
                                          alignment: AlignmentDirectional(0,0),
                                          child: Padding(
                                            padding: EdgeInsetsDirectional.fromSTEB(20, 20, 0, 20),
                                            child: SizedBox(
                                              height: 20,
                                              width: 50,
                                              child: Container(
                                                height: double.infinity,
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  color: TransRed,
                                                ),
                                                child: Center(child: Text('15/20')),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              height: 120,
                              decoration: BoxDecoration(
                                color: Colors.white54
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Flexible(child: Align(alignment: AlignmentDirectional(-1,0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(50, 30, 70, 0),
                                    child: Text(
                                      'Учитель Ахмутинова У.М',
                                      style:  TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 18,
                                    ),
                                    ),
                                  ),
                                  )
                                  ),
                                  SizedBox(height: 20,),

                                  Align(
                                    alignment: AlignmentDirectional(-1, 0),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          50, 0, 70, 20),
                                      child: Text(
                                        'Кабинет проведения: T304',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.white54
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(50, 0, 50, 50),
                                child: ElevatedButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context){
                                          return CustomDialog(topicNAME: 'ОП по георафии',count: 10,max: 20,);
                                        });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(horizontal: 24),
                                    primary: Color(0xFF4838D1), // Replace with your desired button color
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
                                          fontWeight: FontWeight.w100 ,
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
              )
              )
            ],
          ),
        ),
      ),
    );
  }
}
