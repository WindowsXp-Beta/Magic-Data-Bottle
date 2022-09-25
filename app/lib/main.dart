import 'package:data_bottle/utils/route_generator.dart';
import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Trust Worthy',
      initialRoute: RouteGenerator.nfcVerify,
      onGenerateRoute: RouteGenerator.generateRoute,
      // navigatorKey: GlobalUtils.navKey,
    );
  }
}