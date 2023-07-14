import 'package:excel/excel.dart';

makeExcelUsersDoc(Map userList) {
  var excel = Excel.createExcel();

  CellStyle headingStyle = CellStyle(
    fontColorHex: 'FFFFFFFF',
    backgroundColorHex: 'FF4838D1',
    horizontalAlign: HorizontalAlign.Center,
    verticalAlign: VerticalAlign.Center,
    leftBorder: Border(
      borderStyle: BorderStyle.Thin,
    ),
    rightBorder: Border(
      borderStyle: BorderStyle.Thin,
    ),
    topBorder: Border(
      borderStyle: BorderStyle.Thin,
    ),
    bottomBorder: Border(
      borderStyle: BorderStyle.Thin,
    ),
  );

  CellStyle contentStyle = CellStyle(
    leftBorder: Border(
      borderStyle: BorderStyle.Thin,
    ),
    rightBorder: Border(
      borderStyle: BorderStyle.Thin,
    ),
    topBorder: Border(
      borderStyle: BorderStyle.Thin,
    ),
    bottomBorder: Border(borderStyle: BorderStyle.Thin),
  );

  //Admins
  var adminSheet = excel['Админы'];
  excel.setDefaultSheet('Админы');
  excel.delete('Sheet1');
  adminSheet.setColAutoFit(0);
  adminSheet.updateCell(
      CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0), 'Почта',
      cellStyle: headingStyle);
  adminSheet.setColAutoFit(1);
  adminSheet.updateCell(
      CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: 0), 'ФИО',
      cellStyle: headingStyle);
  Map adminMap = Map();
  userList.forEach((key, value) {
    if (value['role'] == 'Admin') {
      adminMap.addAll({key: value});
    }
  });
  int i = 1;
  adminMap.forEach((key, value) {
    adminSheet.updateCell(
        CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i),
        value['email'] ?? '',
        cellStyle: contentStyle);
    adminSheet.updateCell(
        CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: i),
        value['fio'] ?? '',
        cellStyle: contentStyle);
    i++;
  });

  //Teachers
  var teacherSheet = excel['Учителя'];
  teacherSheet.setColAutoFit(0);
  teacherSheet.updateCell(
      CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0), 'Почта',
      cellStyle: headingStyle);
  teacherSheet.setColAutoFit(1);
  teacherSheet.updateCell(
      CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: 0), 'ФИО',
      cellStyle: headingStyle);
  teacherSheet.setColAutoFit(2);
  teacherSheet.updateCell(
      CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: 0), 'Курсы',
      cellStyle: headingStyle);
  Map teacherMap = Map();
  userList.forEach((key, value) {
    if (value['role'] == 'Teacher') {
      teacherMap.addAll({key: value});
    }
  });
  i = 1;
  teacherMap.forEach((key, value) {
    teacherSheet.updateCell(
        CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i),
        value['email'] ?? '',
        cellStyle: contentStyle);
    teacherSheet.updateCell(
        CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: i),
        value['fio'] ?? '',
        cellStyle: contentStyle);
    teacherSheet.updateCell(
        CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: i),
        (value['courses'] as Map?)?.keys.join(', ') ?? '',
        cellStyle: contentStyle);
    i++;
  });

  //Students
  var studentSheet = excel['Ученики'];
  studentSheet.setColAutoFit(0);
  studentSheet.updateCell(
      CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0), 'Почта',
      cellStyle: headingStyle);
  studentSheet.setColAutoFit(1);
  studentSheet.updateCell(
      CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: 0), 'ФИО',
      cellStyle: headingStyle);
  studentSheet.setColAutoFit(2);
  studentSheet.updateCell(
      CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: 0), 'Класс',
      cellStyle: headingStyle);
  studentSheet.setColAutoFit(3);
  studentSheet.updateCell(
      CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: 0), 'Кол-во записей',
      cellStyle: headingStyle);
  studentSheet.setColAutoFit(4);
  studentSheet.updateCell(
      CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: 0), 'Курс',
      cellStyle: headingStyle);
  studentSheet.setColAutoFit(5);
  studentSheet.updateCell(
      CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: 0), 'Кружок',
      cellStyle: headingStyle);
  studentSheet.setColAutoFit(6);
  studentSheet.updateCell(
      CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: 0), 'Секция',
      cellStyle: headingStyle);
  Map studentMap = Map();
  userList.forEach((key, value) {
    if (value['role'] == 'Student') {
      studentMap.addAll({key: value});
    }
  });
  i = 1;
  studentMap.forEach((key, value) {
    studentSheet.updateCell(
        CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i),
        value['email'] ?? '',
        cellStyle: contentStyle);
    studentSheet.updateCell(
        CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: i),
        value['fio'] ?? '',
        cellStyle: contentStyle);
    studentSheet.updateCell(
        CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: i),
        value['grade'] ?? '',
        cellStyle: contentStyle);
    int subs = 0;
    Map courses = value['courses'];
    if (courses['курсы'] != null) subs++;
    if (courses['Кружки'] != null) subs++;
    if (courses['Секция'] != null) subs++;
    studentSheet.updateCell(
        CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: i), subs,
        cellStyle: CellStyle(
          leftBorder: Border(
            borderStyle: BorderStyle.Thin,
          ),
          rightBorder: Border(
            borderStyle: BorderStyle.Thin,
          ),
          topBorder: Border(
            borderStyle: BorderStyle.Thin,
          ),
          bottomBorder: Border(borderStyle: BorderStyle.Thin),
          bold: true,
          fontColorHex: subs == 0
              ? 'FFFF0000'
              : subs == 1
                  ? 'FFFF6D01'
                  : subs == 2
                      ? 'FFFFCC00'
                      : 'FF00B050',
        ));
    studentSheet.updateCell(
        CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: i),
        courses['курсы'] ?? '',
        cellStyle: contentStyle);
    studentSheet.updateCell(
        CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: i),
        courses['Кружки'] ?? '',
        cellStyle: contentStyle);
    studentSheet.updateCell(
        CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: i),
        courses['Секция'] ?? '',
        cellStyle: contentStyle);
    i++;
  });

  excel.save(fileName: 'Пользователи.xlsx');
}
