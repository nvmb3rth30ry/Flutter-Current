void main() {
  String n = '46536278.99';

  String formatNumberStringWithCommas(String rawNumber) {
    String niceNumber = '';
    String cents = '';
    if (rawNumber.contains('.')) {
      List<String> decimalSplit = rawNumber.split('.');
      rawNumber = decimalSplit[0];
      cents = '.' + decimalSplit[1];
    }
    double commas = rawNumber.length / 3;
    int leadDigits = rawNumber.length - 3 * commas.toInt();

    if (rawNumber.length > 3) {
      for (int c = rawNumber.length; c >= 3; c = c - 3) {
        if (c > 3) {
          niceNumber = ',' + rawNumber.substring(c - 3, c) + niceNumber;
        } else {
          niceNumber = rawNumber.substring(c - 3, c) + niceNumber;
        }
      }
      niceNumber = rawNumber.substring(0, leadDigits) + niceNumber;
    } else {
      niceNumber = rawNumber;
    }
    return niceNumber + cents;
  }

  void commaTestSuite(List<String> list) {
    String converted = '';

    print('Test START');
    for (String number in list) {
      converted = formatNumberStringWithCommas(number);
      print('outcome: \'$number\' > \'$converted\'');
    }
    print('Test ENDS.\n');
  }

  String commafied = formatNumberStringWithCommas(n);
  print('commafied = $commafied');
}
