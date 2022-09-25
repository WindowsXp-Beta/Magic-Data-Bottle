import 'dart:convert';
import 'dart:io';

import 'package:data_bottle/assets/constant.dart';
import 'package:data_bottle/assets/custom_style.dart';
import 'package:data_bottle/assets/fake_data.dart';
import 'package:data_bottle/utils/route_generator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class CalculateProgressPage extends StatefulWidget {
  const CalculateProgressPage({Key? key}) : super(key: key);

  @override
  _CalculateProgressPageState createState() => _CalculateProgressPageState();
}

class _CalculateProgressPageState extends State<CalculateProgressPage> {
  @override
  void initState() {
    super.initState();
    Socket.connect("192.168.12.58", 9999).then((socket) {
      socket.write("score 1");
      socket.listen(
        (var ret) {
          FakeData.score_data = Utf8Decoder().convert(ret).split('\n');
          Future.delayed(const Duration(seconds: 3), () {
            Navigator.pushNamed(
                context, RouteGenerator.showScorePage);
          });
        },
        onError: (error) {
          socket.destroy();
        },
        onDone: () {
          socket.destroy();
        },
      );
    });
    // Future.delayed(const Duration(seconds: 3), () {
    //   Navigator.pushNamed(
    //       context, RouteGenerator.showScorePage);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomScrollView(
        slivers: [
          SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 1.5),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return buildCircleChart(FakeData.supportedDataSource[index],
                    Colors.lightBlue, FakeData.dataSourceLoadingTime[index]);
              },
              childCount: FakeData.supportedDataSource.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCircleChart(String source, Color color, int duration) {
    return CircularPercentIndicator(
      radius: 250.0,
      animation: true,
      animationDuration: duration,
      lineWidth: 20.0,
      percent: 1.0,
      center: Text(
        source,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30.0,
          color: CustomStyles.normalFontColor,
        ),
      ),
      progressColor: color,
    );
  }
}
