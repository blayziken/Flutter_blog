import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkHandler {
  String baseURL = 'https://bloggy-backend-api.herokuapp.com';

//  String appendUrl(url) {
//    return baseURL + url;
//  }

  Future get(String url) async {
    var callUrl = Uri.parse('$baseURL/$url');

    var response = await http.get(callUrl);
    try {
      return json.decode(response.body);
    } catch (err) {
      print(err);
    }
  }

  Future<http.Response> postData(String url, Map<String, String> body) async {
    var callUrl = Uri.parse('$baseURL/$url');

    var response = await http.post(callUrl,
        body: json.encode(body), headers: {"Content-type": "application/json"});

    print(response.body);
    return (response);
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
