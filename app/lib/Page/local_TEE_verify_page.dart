import 'package:data_bottle/assets/constant.dart';
import 'package:data_bottle/assets/custom_style.dart';
import 'package:data_bottle/assets/fake_data.dart';
import 'package:data_bottle/utils/route_generator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LocalTEEVerifyPage extends StatefulWidget {
  @override
  _LocalTEEVerifyPageState createState() => _LocalTEEVerifyPageState();
}

class _LocalTEEVerifyPageState extends State<LocalTEEVerifyPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: FakeData.defaultLoadingTime), () {
      Navigator.pushNamed(context, RouteGenerator.localTEEVerifyPassRoute);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.travel_explore,
            size: 100.0,
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "检测本地TEE运行环境",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: Constants.verifyPageFontSize,
                  color: CustomStyles.normalFontColor,
                ),
              ),
              CupertinoActivityIndicator(
                radius: 15.0,
              )
            ],
          ),
        ],
      ),
    );
  }
}
