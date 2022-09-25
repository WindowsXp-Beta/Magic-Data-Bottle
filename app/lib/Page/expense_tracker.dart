import 'dart:convert';
import 'dart:io';

import 'package:data_bottle/assets/constant.dart';
import 'package:data_bottle/assets/custom_style.dart';
import 'package:data_bottle/assets/fake_data.dart';
import 'package:data_bottle/widgets/timeline_dot.dart';
import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_timeline/event_item.dart';
import 'package:flutter_timeline/indicator_position.dart';
import 'package:flutter_timeline/timeline.dart';
import 'package:flutter_timeline/timeline_theme.dart';
import 'package:flutter_timeline/timeline_theme_data.dart';

class ExpenseTracker extends StatefulWidget {
  const ExpenseTracker({Key? key}) : super(key: key);

  @override
  _ExpenseTrackerState createState() => _ExpenseTrackerState();
}

class _ExpenseTrackerState extends State<ExpenseTracker> {
  final expenseList = <TimelineEventDisplay>[];
  final dataList = <String>[];

  // Future<String> get _localPath async {
  //   final directory = await getApplicationDocumentsDirectory();
  //
  //   return directory.path;
  // }
  // Future<File> get _localFile async {
  //   final path = await _localPath;
  //   print(_localPath);
  //   return File('$path/counter.txt');
  // }
  // File? _file;

  @override
  Widget build(BuildContext context) {
    // return FutureBuilder<void>(
    //   future: _initData(),
    //   builder: (_, snapshot) {
    //     if (!snapshot.hasData) {
    //       return Scaffold(
    //         appBar: AppBar(
    //           elevation: 0.5,
    //         ),
    //         body: _buildEmptyWidget(),
    //       );
    //     }
        parseData();
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 300),
          child: TimelineTheme(
              data: TimelineThemeData(
                  lineColor: Colors.blueGrey, itemGap: 100, lineGap: 0),
              child: Timeline(
                anchor: IndicatorPosition.center,
                indicatorSize: 80,
                events: expenseList,
                shrinkWrap: false,
              )),
        );
      // },
    // );
  }

  Widget _buildEmptyWidget() => Center(
        child: Padding(
          padding: const EdgeInsets.all(80.0),
          child: EmptyWidget(
            image: null,
            packageImage: PackageImage.Image_2,
          ),
        ),
      );

  Future<void> _initData() async {
    Socket.connect("192.168.12.58", 9999).then((socket) {
      print("connect to TA succeed");
      // socket.write("read ${widget._dataSource} 0");
      socket.listen((var ret) {
        this.setState(() {
          // _data = Utf8Decoder().convert(ret);
        });
        socket.destroy();
      }, onError: (error) {
        socket.destroy();
      }, onDone: () {
        socket.destroy();
      });
    });
  }

  void parseData() {
    var keyList = FakeData.csvMap.keys.toList();
    // parse data source(String) into List
    var itemListMap = <String, List<List<String>>>{};
    // current iterator of each data source
    var pointerMap = <String, int>{};
    // current data item of multiple data source
    // change after iterator move forward
    var currentDataItemMap = <String, List<String>>{};

    for (var key in keyList) {
      var data = FakeData.csvMap[key]!.split('\n').toSet().toList().where((e) => e != "").map((e) => e.split(',').map((e) => e.trim()).toList()).toList();
      // sort by time in descend order
      data.sort((a, b) {
        int aTime = DateTime.parse(a[timePosition[key]!]).millisecondsSinceEpoch;
        int bTime = DateTime.parse(b[timePosition[key]!]).millisecondsSinceEpoch;
        return bTime.compareTo(aTime);
      });
      itemListMap[key] = data;
      pointerMap[key] = 0;
    }
    while (true) {
      String keyMax = "";
      int timeMax = 0;
      for (var key in keyList) {
        int itemTime = DateTime.parse(itemListMap[key]![pointerMap[key]!][timePosition[key]!]).millisecondsSinceEpoch;
        if (itemTime > timeMax) {
          keyMax = key;
          timeMax = itemTime;
        }
      }
      int nextPointer = pointerMap[keyMax]! + 1;
      var latestItem = itemListMap[keyMax]![pointerMap[keyMax]!];
      var body = <String>[];
      for (var position in bodyPosition[keyMax]!) {
        body.add(latestItem[position]);
      }
      expenseList.add(
        TimelineEventDisplay(
            child: TimelineEventCard(
              title: Text(latestItem[ioPosition[keyMax]!], style: CustomStyles.timelineTitleStyle),
              content: Text(body.join('\n'),
                  style: CustomStyles.timelineContentStyle),
            ),
            indicator: TimeLineDot(iconDataMap[keyMax], colorDataMap[keyMax])),
      );
      if (nextPointer == itemListMap[keyMax]!.length) {
        keyList.remove(keyMax);
        if (keyList.isEmpty) break;
      } else {
        pointerMap[keyMax] = nextPointer;
      }
    }
    // expenseList.add(
    //   TimelineEventDisplay(
    //       child: TimelineEventCard(
    //         title: Text("", style: CustomStyles.timelineTitleStyle),
    //         content: Text(FakeData.csvMap["支付宝"]!,
    //             style: CustomStyles.timelineContentStyle),
    //       ),
    //   )
    // );

    // itemList.removeLast();
    // for (String item in itemList) {
    //   var splitResult = item.split(r',');
    //   var title = splitResult[4];
    //   var detail = splitResult;
    //   detail.removeAt(4);
    //   //remove unnecessary details
    //   detail.removeLast();
    //   detail.removeLast();
    //   detail.removeLast();
    //   detail.removeLast();
    //   detail.removeLast();
    //
    //   expenseList.add(
    //     TimelineEventDisplay(
    //         child: TimelineEventCard(
    //           title: Text(title, style: CustomStyles.timelineTitleStyle),
    //           content: Text(detail.join('\n'),
    //               style: CustomStyles.timelineContentStyle),
    //         ),
    //         indicator: TimeLineDot(iconData, color)),
    //   );
    // }
  }
}
