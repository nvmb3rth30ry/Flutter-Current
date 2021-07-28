import 'package:bitcoin_ticker/utilities/defined.dart';
import 'package:flutter/material.dart';
import 'package:bitcoin_ticker/components/coin_card.dart';
import 'package:bitcoin_ticker/services/coin_data.dart';
// --

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker Ldr'),
      ),
      body: Container(
        child: Center(
          child: Text(
            'Hello World, I\'m Bitcoin.',
            style: TextStyle(
              color: kBlack,
            ),
          ),
        ),
      ),
    );
  }
}
