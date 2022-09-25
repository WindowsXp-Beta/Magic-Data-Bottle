import 'dart:typed_data';

import 'package:data_bottle/assets/constant.dart';
import 'package:data_bottle/assets/custom_style.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:usb_serial/usb_serial.dart';
import 'package:logger/logger.dart';

class IdentityVerifyPage extends StatefulWidget {
  final String _route;

  const IdentityVerifyPage(this._route, {Key? key}) : super(key: key);

  @override
  _IdentityVerifyPageState createState() => _IdentityVerifyPageState();
}

class _IdentityVerifyPageState extends State<IdentityVerifyPage> {
  // First, _isLoading is used to indicate if the USB has been initialized
  // Second, _isLoading is used to indicate if the NFC verification has finished
  bool _isLoading = true;

  var _port;
  var _subscription;
  var _logger;


  final _verticalSpace = Expanded(flex: 20, child: Container());

  final _gap = Expanded(
    flex: 3,
    child: Container(),
  );

  Future<void> initUSB() async {
    _logger = Logger();
    List<UsbDevice> devices = await UsbSerial.listDevices();
    for (var device in devices) {
      if (device.manufacturerName!.startsWith("Arduino")){
        _port = await device.create();
        if (!await _port.open()) {
          _logger.e("port open failed");
        }
        await _port.setDTR(true);
        await _port.setRTS(true);
        await _port.setPortParameters(
            115200, UsbPort.DATABITS_8, UsbPort.STOPBITS_1, UsbPort.PARITY_NONE);

        _subscription = _port.inputStream.listen((Uint8List line) {
          var line2string = new String.fromCharCodes(line);
          if (line2string == "s") {
            setState(() {
              _isLoading = false;
            });
            Navigator.pushNamed(context, widget._route);
          }
        });
      }
    }
  }
  
  @override
  void initState() {
    super.initState();
    
    initUSB().then((value) => {
      setState(() {
        _isLoading = false;
      })
    });
  }

  @override
  void dispose() {
    super.dispose();
    if ( _port != null ) {
      _subscription.cancel();
      _port.close();
      _port = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 50.0),
      child: Center(
        child: Column(
          children: [
            Expanded(flex: 8, child: Container()),
            Expanded(
              flex: 12,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.warning,
                    size: 60.0,
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Text(
                    "开启数据魔瓶",
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
            _gap,
            Expanded(
                flex: 10,
                child: Text(
                  "请刷卡",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 30.0,
                    color: CustomStyles.normalFontColor,
                  ),
                )),
            _gap,
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
                          Icons.sim_card_alert,
                          size: Constants.fingerPrintSize,
                        ),
                        onPressed: () {
                          setState(() {
                            _isLoading = true;
                          });
                          _port.write(Uint8List.fromList("b".codeUnits));
                        },
                      )),
            _verticalSpace,
          ],
        ),
      ),
    );
  }
}
