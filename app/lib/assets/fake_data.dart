import 'package:data_bottle/assets/constant.dart';
import 'package:data_bottle/assets/custom_style.dart';
import 'package:data_bottle/widgets/timeline_dot.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_timeline/defaults.dart';
import 'package:flutter_timeline/event_item.dart';

class FakeData {
  static const wechat = <String>[
    "微信"
  ];
  static const supportedDataSource = <String>[
    "支付宝",
    "微信",
    // "中国银行",
    // "交通银行",
    // "建设银行",
    // "农业银行",
  ];
  static String choseDataSource = "微信";

  static List<String> score_data = [];
  //csv get from cloud TEE
  //<data source, data>
  // static final csvMap = <String, String>{};
  static final csvMap = Map.fromEntries([
    MapEntry("微信", '2021-11-21 17:31:36 ,商户消费,上海交通大学,"大众餐厅",支出,¥9.44,浙江农信(0075),支付成功,4200001121202111201192806244	,20211120107556373	,"/"\n2021-11-20 00:45:53,微信红包（单发）,发给🍋dp typec,"/",支出,¥20.00,浙江农信(0075),支付成功,100003980121112000094332483769606568	,1000039801202111206104809259138	,"/"\n')
  ]);

  static const dataSourceLoadingTime = <int>[
    1000,
    1300,
    1700,
    1900,
    2400,
    2800
  ];

  static const dataSourceLogo = <Icon>[
    Icon(AntDesign.alipay_circle),
    Icon(AntDesign.wechat),
    Icon(Icons.account_balance),
    Icon(Icons.account_balance),
    Icon(Icons.account_balance),
    Icon(Icons.account_balance),
  ];

  static const buyCount = <int>[
    28,
    45,
    19,
    20,
    34,
    27,
  ];

  static const loanCount = <int>[
    15,
    22,
    7,
    9,
    4,
    5,
  ];

  static const defaultLoadingTime = 2;

  static final expenseList = <TimelineEventDisplay>[
    TimelineEventDisplay(
        child: TimelineEventCard(
          title: Text("消费", style: CustomStyles.timelineTitleStyle),
          content: Text(
              "你使用支付宝购买了一台MacBook Pro\n共计￥15000\n${DateTime.utc(2020, 3, 25, 7, 8, 32, 52, 15)}",
              style: CustomStyles.timelineContentStyle),
        ),
        indicator: TimeLineDot(AntDesign.alipay_circle, Colors.blueAccent)),
    TimelineEventDisplay(
        child: TimelineEventCard(
          title: Text("消费", style: CustomStyles.timelineTitleStyle),
          content: Text(
              "你使用微信支付购买了一台iPhone 12\n共计￥8000\n${DateTime.utc(2020, 2, 18, 9, 25, 14, 52, 15)}",
              style: CustomStyles.timelineContentStyle),
        ),
        indicator: TimeLineDot(AntDesign.wechat, Colors.green)),
    TimelineEventDisplay(
        child: TimelineEventCard(
          title: Text("还款", style: CustomStyles.timelineTitleStyle),
          content: Text(
              "你还清了上个月的花呗\n共计￥5000\n${DateTime.utc(2020, 2, 18, 9, 25, 14, 52, 15)}",
              style: CustomStyles.timelineContentStyle),
        ),
        indicator: TimeLineDot(AntDesign.alipay_circle, Colors.blueAccent)),
    TimelineEventDisplay(
        child: TimelineEventCard(
          title: Text("还款", style: CustomStyles.timelineTitleStyle),
          content: Text(
              "你还清了上个月的房贷\n共计￥10000\n${DateTime.utc(2020, 2, 18, 9, 25, 14, 52, 15)}",
              style: CustomStyles.timelineContentStyle),
        ),
        indicator: TimeLineDot(Icons.account_balance, Colors.greenAccent)),
  ];
}
