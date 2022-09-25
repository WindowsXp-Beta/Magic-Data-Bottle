import 'package:data_bottle/assets/custom_style.dart';
import 'package:data_bottle/assets/fake_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShowScorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: NestedScrollView(
            headerSliverBuilder: (context, value) =>
                [SliverToBoxAdapter(child: null)],
            body: _buildListView()));
  }

  Widget _buildListView() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: FakeData.score_data.length * 2,
        itemBuilder: (context, i) {
          if (i.isOdd)
            return new Divider(
              color: Colors.blueGrey,
            );
          final index = i ~/ 2;
          return _buildRow(FakeData.score_data[index]);
        });
  }

  Widget _buildRow(String data) {
    return Center(
        child: Text(
      data,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 40,
        color: CustomStyles.normalFontColor,
      ),
    ));
  }
}
