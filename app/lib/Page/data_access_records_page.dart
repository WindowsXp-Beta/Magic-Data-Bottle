import 'package:data_bottle/assets/constant.dart';
import 'package:data_bottle/assets/custom_style.dart';
import 'package:data_bottle/assets/fake_data.dart';
import 'package:data_bottle/utils/route_generator.dart';
import 'package:data_bottle/widgets/data_access_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class DataAccessRecordsPage extends StatefulWidget {
  const DataAccessRecordsPage({Key? key}) : super(key: key);

  @override
  _DataAccessRecordsPageState createState() => _DataAccessRecordsPageState();
}

class _DataAccessRecordsPageState extends State<DataAccessRecordsPage> {

  @override
  void initState(){
    super.initState();
    Future.delayed(const Duration(seconds: 5), (){
      Navigator.pushNamed(context, RouteGenerator.ifSendReportRoute);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomScrollView(
        slivers: [
          SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 1.5),
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                return DataAccessCard("交通银行", FakeData.supportedDataSource[index], FakeData.dataSourceLogo[index], FakeData.buyCount[index], FakeData.loanCount[index]);
              },
              childCount: FakeData.supportedDataSource.length,
            ),
          ),
        ],
      ),
    );
  }
}
