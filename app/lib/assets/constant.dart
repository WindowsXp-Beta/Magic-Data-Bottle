import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter/material.dart';

class Constants{

  static const buttonBorderRadius = 10.0;
  static const timelineTitleSize = 30.0;
  static const timelineContentSize = 20.0;
  static const verifyPageFontSize = 40.0;
  static const verifyPassFontSize = 40.0;
  static const acceptOrNotFontSize = 40.0;
  static const fingerPrintSize = 80.0;
  static const inputCommandFontSize = 50.0;

}

enum ChooseDataSourceType {
  ImportData,
  UseData
}

final timePosition = <String, int>{
  "微信": 0,
  "支付宝": 10,
};

final ioPosition = <String, int>{
  "微信": 4,
  "支付宝": 0
};

final bodyPosition = <String, List<int>>{
  "微信": [0, 2, 5],
  "支付宝": [10, 1, 5]
};

final iconDataMap = <String, Object>{
  "微信": AntDesign.wechat,
  "支付宝": AntDesign.alipay_circle
};

final colorDataMap = <String, Object>{
  "微信": Colors.green,
  "支付宝": Colors.blueAccent
};

