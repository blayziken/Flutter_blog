import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkHandler {
  String baseURL = 'https://bloggy-backend-api.herokuapp.com/';

  Future postData(url, body) async {
    url = Uri.parse('baseURL/$url');

    http.Response response = await http.post(url, body: body);

    if (response.statusCode == 200) {
      String data = response.body;
      print('Http Post successful');

      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}
