
import 'dart:convert';

import 'package:http/http.dart' as http;


class NetworkHelper {
  NetworkHelper(this.url);

  final String url;


  Future getData() async {
    var url2 = Uri.parse(url);
    http.Response response = await http.get(url2);
    //print(response.body);
    String data = response.body;
    if (response.statusCode == 200) {
      var decodedData = jsonDecode(data);
      return decodedData;
    }
  }
}