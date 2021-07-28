import 'package:flutter/material.dart';
import 'package:bitcoin_ticker/services/networking.dart';
// --

const List<String> fiatList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  Future<double> getCoinPrice(String symbol, String fiatSymbol) async {
    const coinApiKey = '1BF956E6-5AA7-4FA5-8AAB-A5C6B1EDCE05';
    const urlPrefix = 'https://rest.coinapi.io/v1/exchangerate';
    String coinRequest = '$urlPrefix/$symbol/$fiatSymbol?apikey=$coinApiKey';
    NetworkHelper netHelper = NetworkHelper(coinRequest);

    var curRateData = await netHelper.getData();

    // setState(() {
    //   selectedFiatValue = curRateData['rate'];
    // });
    return curRateData['rate'];
  }
}
