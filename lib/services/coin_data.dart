import 'package:http/http.dart' as http;
import 'dart:convert';
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

const coinApiKey = '1BF956E6-5AA7-4FA5-8AAB-A5C6B1EDCE05';
const urlPrefix = 'https://rest.coinapi.io/v1/exchangerate';

class CoinData {
  Future getCoinRates(String fiatSymbol) async {

    Map<String, String> allCryptoRates = {};

    for (String symbol in cryptoList) {
      String coinRequest = '$urlPrefix/$symbol/$fiatSymbol?apikey=$coinApiKey';
      http.Response response = await http.get(Uri.parse(coinRequest));
      if (response.statusCode == 200) {
        var curRateData = jsonDecode(response.body);
        double fRate = curRateData['rate'];
        allCryptoRates[symbol] = fRate.toStringAsFixed(2);
      } else {
        print('Oops. ${response.statusCode}');
        throw 'Problem with the get request';
      }
    }
    print('Reloaded \'allCryptoRates\' for [$fiatSymbol] = $allCryptoRates');
    return allCryptoRates;
  }
}
