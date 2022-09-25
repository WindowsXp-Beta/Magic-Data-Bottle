import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TimeLineDot extends StatelessWidget {
  final _icon;
  final _color;
  
  TimeLineDot(this._icon, this._color);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      child: Icon(
        _icon,
        color: Colors.white,
        size: 50,
      ),
      decoration: BoxDecoration(
          color: _color,
          borderRadius: BorderRadius.all(
            Radius.circular(64),
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.lightBlueAccent,
                blurRadius: 16,
                offset: Offset(0, 4))
          ]),
    );
  }
}