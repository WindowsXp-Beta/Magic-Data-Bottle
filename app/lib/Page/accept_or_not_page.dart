import 'package:data_bottle/assets/constant.dart';
import 'package:data_bottle/assets/custom_style.dart';
import 'package:data_bottle/utils/route_generator.dart';
import 'package:data_bottle/widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AcceptOrNotPage extends StatelessWidget {
  final _decisionMessage;
  final Widget _topWidget;
  final _route;

  AcceptOrNotPage(this._decisionMessage, this._topWidget, this._route,
      {Key? key})
      : super(key: key);

  final _gap = Expanded(flex: 2, child: Container());

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(flex: 10, child: Container()),
          Expanded(
            flex: 20,
            child: _topWidget,
          ),
          _gap,
          Expanded(
            flex: 20,
            child: Column(children: [
              Text(
                _decisionMessage,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: Constants.acceptOrNotFontSize,
                  color: CustomStyles.normalFontColor,
                ),
              ),
              Text(
                "是否同意？",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: Constants.acceptOrNotFontSize,
                  color: CustomStyles.normalFontColor,
                ),
              ),
            ]),
          ),
          _gap,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomButton(
                  Icon(Icons.check_circle_outline), "接受", _route, 120, 50, color: Colors.greenAccent,),
              CustomButton(Icon(Icons.highlight_off), "拒绝", "/", 120, 50, color: Colors.redAccent,),
            ],
          ),
          Expanded(flex: 20, child: Container()),
        ],
      ),
    );
  }
}
