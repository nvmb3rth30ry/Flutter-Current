import 'package:flutter/material.dart';
import 'package:bitcoin_ticker/utilities/defined.dart';
import 'package:bitcoin_ticker/utilities/util.dart';

class CoinCard extends StatelessWidget {
  CoinCard({this.symbol, this.fiatSymbol, this.fiatValue, this.onPress});

  final String symbol;
  final Function onPress;
  final String fiatSymbol;
  final String fiatValue;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress, // Tap event listener!
      child: Padding(
        padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
        child: Card(
          color: Colors.cyan[900],
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
            child: Text(
              '1 $symbol = $fiatValue $fiatSymbol',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
                color: kWhite,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
