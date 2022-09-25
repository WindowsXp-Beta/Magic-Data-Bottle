import 'package:data_bottle/assets/constant.dart';
import 'package:data_bottle/utils/route_generator.dart';
import 'package:data_bottle/widgets/custom_button.dart';
import 'package:data_bottle/widgets/homepage_tablet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChooseTAPage extends StatelessWidget {
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
              HomepageTablet(Icon(Icons.calculate, size: 120, color: Colors.black,), "交通银行计算程序", RouteGenerator.localTEEVerifyRoute, 240, 300),
            ),
            _gap,
            Expanded(
              flex: 3,
              child:
              HomepageTablet(Icon(Icons.receipt_long, size: 120, color: Colors.black,), "购车保险", '/', 240, 300),
            ),
            _gap,
            Expanded(
              flex: 3,
              child:
              HomepageTablet(Icon(Icons.health_and_safety, size: 120, color: Colors.black,), "人身安全保险", '/', 240, 300),
            ),
          ],
        ),
      ),
    );
  }
}
