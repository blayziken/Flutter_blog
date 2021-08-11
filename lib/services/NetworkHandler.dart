import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkHandler {
  String baseURL = 'https://bloggy-backend-api.herokuapp.com';

//  String appendUrl(url) {
//    return baseURL + url;
//  }

  Future<dynamic> postData(String url, Map<String, String> body) async {
    var callUrl = Uri.parse('$baseURL/$url');

    var response = await http.post(callUrl, body: body);

    try {
      print('------------');
      print(response.body);
      print('------------');
      return jsonDecode(response.body);
    } catch (err) {
      print(err);
    }
  }
//    if (response.statusCode == 200) {
//      String data = response.body;
//      print('Http Post successful');
//      print(data);
//      print('------------');
//      return jsonDecode(data);
//    } else {
//      print(response.statusCode);
//    }
//  }
}
