import 'dart:convert';
import 'dart:io';

import 'package:data_bottle/assets/constant.dart';
import 'package:data_bottle/assets/custom_style.dart';
import 'package:data_bottle/assets/fake_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InputPage extends StatefulWidget {
  final String _route;

  const InputPage(this._route, {Key? key}) : super(key: key);

  @override
  createState() => _InputPage();
}

class _InputPage extends State<InputPage> {
  bool _isLoading = false;
  late TextEditingController _passwordController;

  final _gap = Expanded(
    flex: 3,
    child: Container(),
  );

  final _verticalSpace = Expanded(flex: 20, child: Container());

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 50.0),
      child: Center(
        child: Column(children: [
          Expanded(flex: 8, child: Container()),
          Expanded(
            flex: 12,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.perm_identity,
                  size: 60.0,
                ),
                SizedBox(
                  width: 5.0,
                ),
                Text(
                  '输入${FakeData.choseDataSource}解压码',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 50.0,
                    color: CustomStyles.normalFontColor,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 10,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: Container(),
                ),
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    controller: _passwordController,
                    style: CustomStyles.inputPromptTitleStyle,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(),
                ),
              ],
            ),
          ),
          Expanded(
              flex: 10,
              child: _isLoading
                  ? CupertinoActivityIndicator(
                      radius: Constants.fingerPrintSize / 2,
                    )
                  : IconButton(
                      padding: EdgeInsets.all(0),
                      iconSize: Constants.fingerPrintSize,
                      icon: Icon(
                        Icons.check,
                        size: Constants.fingerPrintSize,
                      ),
                      onPressed: () {
                        setState(() {
                          _isLoading = true;
                        });
                        print('password is ${_passwordController.text}');
                        //connect to data server
                        Socket.connect("192.168.12.58", 9999).then((socket) {
                          print("connect to server succeed");
                          String translateDataSource = "";
                          switch (FakeData.choseDataSource) {
                            case "微信": translateDataSource = "wechat";
                            break;
                            case "支付宝": translateDataSource = "alipay";
                            break;
                          }
                          String request = '${translateDataSource} ${_passwordController.text}';
                          socket.write(request);
                          socket.listen(
                            // handle data from the server
                            (var ret) {
                              FakeData.csvMap[FakeData.choseDataSource] = (FakeData.csvMap[FakeData.choseDataSource] ?? "") + Utf8Decoder().convert(ret);
                              // final data = Utf8Decoder().convert(ret);
                              // socket.destroy();
                              // Socket.connect("127.0.0.1", 13000).then((socket) {
                              //   print("connect to TA succeed");
                              //   socket.write("write ${FakeData.choseDataSource} ${data.length}");
                              //   socket.write(data);
                              //   print("send all the data to TA");
                              // });
                              setState(() {
                                _isLoading = false;
                              });
                              Navigator.pushNamed(context, widget._route);
                            },
                            onError: (error) {
                              socket.destroy();
                            },
                            onDone: () {
                              socket.destroy();
                            },
                          );
                        });
                      })),
        ]),
      ),
    );
  }
}
