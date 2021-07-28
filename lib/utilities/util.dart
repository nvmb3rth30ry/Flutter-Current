// USEFUL utility functions
// ============================================

// FORMAT NUMBER (with COMMAS denoting THOUSANDS)
// Takes a raw number string (with decimal places if need be) and outputs same
// with appropriate commas inserted for optimal readability and display
String formatNumber(String rawNumber) {
  String niceNumber = '';
  String cents = '';

  // split decimal places away
  if (rawNumber.contains('.')) {
    List<String> decimalSplit = rawNumber.split('.');
    rawNumber = decimalSplit[0];
    cents = '.' + decimalSplit[1];
  }

  // derive basic data points
  double commas = rawNumber.length / 3;
  int leadDigits = rawNumber.length - 3 * commas.toInt();

  // loop through string backwards with conditional logic
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
  // add any decimals back and deliver output
  return niceNumber + cents;
}

//
