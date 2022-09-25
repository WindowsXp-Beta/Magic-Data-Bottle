import 'package:data_bottle/assets/constant.dart';
import 'package:data_bottle/utils/route_generator.dart';
import 'package:data_bottle/widgets/custom_button.dart';
import 'package:data_bottle/widgets/homepage_tablet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _gap = Expanded(flex: 1, child: Container());
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 50.0),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 3,
              child:
              HomepageTablet(Icon(Icons.login, size: 120, color: Colors.green,), "导入个人数据", RouteGenerator.chooseDataSourceRoute, 240, 300),
            ),
            _gap,
            Expanded(
              flex: 3,
              child:
              HomepageTablet(Icon(Icons.receipt_long, size: 120, color: Colors.blueAccent,), "查看个人数据", RouteGenerator.viewPersonalData, 240, 300),
            ),
            _gap,
            Expanded(
              flex: 3,
              child:
              HomepageTablet(Icon(Icons.assessment, size: 120, color: Colors.orangeAccent,), "数据使用", RouteGenerator.chooseTA, 240, 300),
            ),
          ],
        ),
      ),
    );
  }
}
