import 'package:data_bottle/assets/custom_style.dart';
import 'package:data_bottle/widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PageContainer extends StatelessWidget {
  final String _title;
  final Widget _content;
  final Widget? bottom;
  final bool needLeadBack;

  PageContainer(this._title, this._content, {this.bottom, this.needLeadBack = true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          _title,
          style: CustomStyles.appBarTextStyle,
        ),
        leading: needLeadBack == false ? null : IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () => {},)
        ],
        centerTitle: true,
      ),
      body: _content,
      bottomNavigationBar: bottom,
    );
  }
}