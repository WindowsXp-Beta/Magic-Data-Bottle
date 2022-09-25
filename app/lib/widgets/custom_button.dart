import 'package:data_bottle/assets/custom_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {

  final _icon;
  final _buttonText;
  final _route;
  final double _width;
  final double _height;
  final Color color;

  CustomButton(this._icon, this._buttonText, this._route, this._width, this._height, {Key? key, this.color = CustomStyles.buttonBackGroundColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return InkWell(
        onTap: _route == null ? null : () => Navigator.pushNamed(context, _route),
        child: Container(
          width: _width,
          height: _height,
          decoration: BoxDecoration(
            color: color,
            borderRadius:
            BorderRadius.all(Radius.circular(_height * 0.5)),
          ),
          padding: EdgeInsets.fromLTRB(20.0, 5, 20.0, 5),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _icon,
                SizedBox(width: _width * 0.07,),
                Text(
                  _buttonText,
                  style: TextStyle(
                    fontSize: _height * 0.4,
                    color: CustomStyles.normalFontColor,
                  ),
                )
              ],
            ),
          ),
        ),
      );
  }
}