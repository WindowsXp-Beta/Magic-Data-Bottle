import 'package:data_bottle/assets/custom_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DataAccessCard extends StatelessWidget {
  final String _dataUser;
  final String _dataSource;
  final Icon _sourceIcon;
  final int _buyCount;
  final int _loanCount;

  DataAccessCard(this._dataUser, this._dataSource, this._sourceIcon,
      this._buyCount, this._loanCount);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        children: [
          ListTile(
            leading: _sourceIcon,
            title: Text(
                "$_dataUser访问了$_dataSource，并",
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
          ),
          _buildAccessItem(_buyCount, "购买"),
          _buildAccessItem(_loanCount, "借贷"),
        ],
      ),
    );
  }

  Widget _buildAccessItem(int count, String dataName) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
      Text(
        "读取了",
        style: TextStyle(
          fontSize: 40.0,
          fontWeight: FontWeight.normal,
          color: CustomStyles.normalFontColor,
        ),
      ),
      Text(
        "$count",
        style: TextStyle(
            fontSize: 60.0,
            fontWeight: FontWeight.bold,
            color: CustomStyles.dataAccessedColor),
      ),
      Text(
        "条$dataName记录",
        style: TextStyle(
          fontSize: 40.0,
          fontWeight: FontWeight.normal,
          color: CustomStyles.normalFontColor,
        ),
      ),
    ]);
  }
}
