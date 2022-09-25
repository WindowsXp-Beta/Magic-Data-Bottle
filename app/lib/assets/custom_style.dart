import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'constant.dart';

class CustomStyles{
  static const appBarTextStyle = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.normal,
      fontSize: 16.0
  );

  static const timelineContentStyle = TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 30.0,
  );

  static const timelineTitleStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 40.0,
  );

  static const importDataSourceStyle = TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 30.0,
  );

  static const inputPromptTitleStyle = TextStyle(
      color: Colors.blueGrey,
      fontWeight: FontWeight.bold,
      fontSize: Constants.inputCommandFontSize);

  static const buttonBackGroundColor = Color.fromARGB(255, 230, 230, 230);
  static const normalFontColor = Color.fromARGB(255, 101, 97, 97);
  static const dataAccessedColor = Colors.red;
}