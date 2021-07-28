import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:bitcoin_ticker/components/coin_card.dart';
import 'package:bitcoin_ticker/services/coin_data.dart';
import 'package:bitcoin_ticker/utilities/util.dart';
import 'package:bitcoin_ticker/services/btc_mega_fetch.dart';
//--

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  Map coinRates = new Map();
  String selectedFiatSymbol = 'AUD';
  bool isWaiting = false;

  @override
  void initState() {
    super.initState();
    // on init of LoadingScreen, do this...
    refreshData();
  }

  void refreshData() async {
    isWaiting = true;
    try {
      var data = await CoinData().getCoinRates(selectedFiatSymbol);
      isWaiting = false;
      setState(() {
        coinRates = data;
      });
    } catch (e) {
      print(e);
    }
  }

  List<CoinCard> buildCryptoCards() {
    List<CoinCard> allTheCards = [];
    for (String card in cryptoList) {
      allTheCards.add(
        CoinCard(
            symbol: card,
            fiatSymbol: selectedFiatSymbol,
            fiatValue: isWaiting ? '???' : coinRates[card],
            onPress: () {
              print('The \'$card\' card was pressed.');
            }),
      );
    }
    return allTheCards;
  }

  List<DropdownMenuItem> buildFiatMenu() {
    // method to do the building
    List<DropdownMenuItem<String>> fiatDropList = [];

    for (String fiatCurrency in fiatList) {
      var fcItem = DropdownMenuItem(
        child: Text(
          fiatCurrency,
        ),
        value: fiatCurrency,
      );

      fiatDropList.add(fcItem);
    }
    return fiatDropList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: buildCryptoCards(),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.cyan[900],
            child: DropdownButton<String>(
              style: TextStyle(
                fontSize: 20,
              ),
              value: selectedFiatSymbol,
              items: buildFiatMenu(), // build a dropdown menu from big list
              onChanged: (symbol) {
                print('Picker-selected FiatSymbol = $symbol');
                setState(() {
                  selectedFiatSymbol = symbol;
                  refreshData();
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
