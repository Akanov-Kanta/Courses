import 'package:courses/pages/courses/createnewcourse.dart';
import 'package:flutter/material.dart';

class CreateNewChapter extends StatefulWidget {
  const CreateNewChapter({Key? key}) : super(key: key);

  @override
  State<CreateNewChapter> createState() => _CreateNewChapterState();
}

class _CreateNewChapterState extends State<CreateNewChapter> {
  TextEditingController _nameOfTheChapter = TextEditingController();
  String? _selected;
  List<String> _chapter = ['1 курс/2 курс', 'Кружки', 'Секция'];

  bool get isFormValid =>
      _nameOfTheChapter.text.isNotEmpty && _selected != null;

  @override
  void dispose() {
    _nameOfTheChapter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth;
    double screenHeight = 400;

    if (MediaQuery.of(context).size.width > 600) {
      screenWidth = 600;
    } else {
      screenWidth = MediaQuery.of(context).size.width;
    }

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      insetPadding: EdgeInsets.zero,
      child: Container(
        width: screenWidth,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
              child: SizedBox(
                width: double.infinity,
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(
                          Icons.close,
                          size: 25,
                        )),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 35),
                        child: Text(
                          'Создание нового раздела',
                          textAlign: TextAlign.center,
                          softWrap: true,
                          style: TextStyle(
                              fontSize: 30,
                              fontFamily: 'Futura',
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  CustomInputField(
                      texting: 'Введите название раздела',
                      controller: _nameOfTheChapter),
                  CustomDropDown(
                    texting: 'Выберите раздел ',
                    selectedOption: _selected,
                    options: _chapter,
                    onChange: (value){
                      _selected = value;
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          print(_selected);
                          if (_nameOfTheChapter.text.isNotEmpty && _selected != null) {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return ConfirmationDialog(
                                    title:
                                        'Вы точно хотите создать новый раздел?',
                                    onConfirm: () {
                                      Navigator.of(context).pop();
                                    },
                                  );
                                });
                          }
                        },
                        child: Text(
                          'Создать',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Futura',
                            fontSize: 19,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors
                              .black, // Replace with your desired button color
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
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

class ConfirmationDialog extends StatelessWidget {
  final String title;
  final Function onConfirm;

  ConfirmationDialog({required this.title, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        height: 150,
        width: 320,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white54,
                borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
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
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.center,
                        child: Text(
                          title,
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
                          child: Text('ДА'),
                          onPressed: () {
                            Navigator.of(context).pop();
                            onConfirm();
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.hovered))
                                  return Color(
                                      0xff3EAE4D); // Зеленый цвет при наведении
                                return Colors
                                    .grey; // Используйте основной цвет кнопки
                              },
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10)),
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
                          child: Text('НЕТ'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.hovered))
                                  return Color(
                                      0xffFF6666); // Красный цвет при наведении
                                return Colors
                                    .grey; // Используйте основной цвет кнопки
                              },
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(10)),
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
