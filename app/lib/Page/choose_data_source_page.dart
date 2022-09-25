import 'package:data_bottle/assets/constant.dart';
import 'package:data_bottle/assets/custom_style.dart';
import 'package:data_bottle/assets/fake_data.dart';
import 'package:data_bottle/widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChooseDataSourcePage extends StatefulWidget {
  final ChooseDataSourceType _type;
  final String _route;

  const ChooseDataSourcePage(this._type, this._route, {Key? key})
      : super(key: key);

  @override
  _ChooseDataSourcePageState createState() => _ChooseDataSourcePageState();
}

class _ChooseDataSourcePageState extends State<ChooseDataSourcePage> {
  late String _title;
  late String _content;


  final _chosen = Set<String>.from(FakeData.wechat);

  @override
  Widget build(BuildContext context) {
    switch (widget._type) {
      case ChooseDataSourceType.ImportData:
        _title = "\"数据魔瓶\"请求使用以下APP的数据";
        _content = "您可以不让\"数据魔瓶\"访问某些APP的数据";
        break;
      case ChooseDataSourceType.UseData:
        _title = "交通银行想要使用本地数据";
        _content = "您可以取消\"交通银行安全应用\"对某些数据的访问";
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "数据选择",
          style: CustomStyles.appBarTextStyle,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () => {},
          )
        ],
        centerTitle: true,
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, value) => [
          SliverToBoxAdapter(
            child: _buildSliverAppBar(),
          )
        ],
        body: _buildListView(),
      ),
      bottomNavigationBar: _buildBottom(widget._route),
    );
  }

  Widget _buildSliverAppBar() {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
            child: Icon(
              Icons.info,
              size: 80,
              color: Colors.redAccent,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
            child: Text(
              _title,
              style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: CustomStyles.normalFontColor),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
            child: Text(
              _content,
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.normal,
                  color: CustomStyles.normalFontColor),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
            child: Text(
              "但这会影响你的信用评级",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.normal,
                  color: CustomStyles.normalFontColor),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildListView() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: FakeData.supportedDataSource.length * 2,
        itemBuilder: (context, i) {
          if (i.isOdd)
            return new Divider(
              color: Colors.blueGrey,
            );
          final index = i ~/ 2;
          return _buildRow(FakeData.supportedDataSource[index],
              FakeData.dataSourceLogo[index]);
        });
  }

  Widget _buildRow(String dataSource, Icon dataIcon) {
    final _value = _chosen.contains(dataSource);
    return CheckboxListTile(
        value: _value,
        title: Row(
          children: [
            dataIcon,
            SizedBox(width: 5,),
            Text(
              dataSource,
              style: CustomStyles.importDataSourceStyle,
            ),
          ],
        ),
        onChanged: (whatever) {
          setState(() {
            //modify display
            _value ? _chosen.remove(dataSource) : _chosen.add(dataSource);
            //modify FakeData
            //if you choose more than one data source the last one you chose will be selected
            if (dataSource == "微信" || dataSource == "支付宝") FakeData.choseDataSource = dataSource;
          });
        });
  }

  Widget _buildBottom(String route) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CustomButton(Icon(Icons.check_circle_outline), "接受", route, 120, 50, color: Colors.greenAccent),
          CustomButton(Icon(Icons.highlight_off), "拒绝", "/", 120, 50, color: Colors.redAccent,),
        ],
      ),
    );
  }
}
