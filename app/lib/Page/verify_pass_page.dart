import 'package:data_bottle/assets/constant.dart';
import 'package:data_bottle/assets/custom_style.dart';
import 'package:data_bottle/assets/fake_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class VerifyPassPage extends StatefulWidget {
  final String _verifyContent;
  final String? _nextMove;
  final String? _successMessage;
  final String route;

  const VerifyPassPage(
      this._verifyContent, this._nextMove, this._successMessage,
      {this.route = "/", Key? key})
      : super(key: key);

  @override
  _VerifyPassPageState createState() => _VerifyPassPageState(_successMessage, route);
}

class _VerifyPassPageState extends State<VerifyPassPage> {
  final String? _successMessage;
  final String _route;

  _VerifyPassPageState(this._successMessage, this._route);

  final _gap = Container(
    height: 10.0,
  );

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: FakeData.defaultLoadingTime), () {
      if (_successMessage != null)
        Fluttertoast.showToast(
            msg: _successMessage!,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.greenAccent,
            textColor: Colors.black,
            fontSize: 20.0);
      Navigator.pushNamed(context, _route);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.task_alt,
            size: 100.0,
          ),
          _gap,
          Text(
            widget._verifyContent,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: Constants.verifyPassFontSize,
              color: CustomStyles.normalFontColor,
            ),
          ),
          _gap,
          widget._nextMove == null ? Container() : Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              widget._nextMove!,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: Constants.verifyPassFontSize,
                color: CustomStyles.normalFontColor,
              ),
            ),
            CupertinoActivityIndicator(
              radius: 20.0,
            )
          ]),
        ],
      ),
    );
  }
}
