import 'package:flutter/material.dart';
import 'screens/loading_screen.dart';
import 'screens/price_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
          primaryColor: Colors.deepOrange,
          scaffoldBackgroundColor: Colors.white),
      home: PriceScreen(), //LoadingScreen(),
    );
  }
}
