import 'package:http/http.dart' as http;
import 'dart:convert';
// --

class NetworkHelper {
  NetworkHelper(this.url);

  final String url;

  Future getData() async {
    // Use built string to make request from API-enabled server
    http.Response response = await http.get(Uri.parse(url));

    // process response data, including data check
    if (response.statusCode == 200) {
      return jsonDecode(response.body); // All OK: send response back to caller

    } else {
      // if things go wrong, spit it all out
      print('Response StatusCode: ' + response.statusCode.toString());
    }
  }
}
