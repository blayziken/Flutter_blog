import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class NetworkHandler {
//  String baseURL = 'https://bloggy-backend-api.herokuapp.com';
  String baseURL = 'http://192.168.43.41:8000';

  // Getting token from storage
  FlutterSecureStorage storage = FlutterSecureStorage();

  Future get(String url) async {
    String token = await storage.read(key: "token");
    var callUrl = Uri.parse('$baseURL/$url');

    var response = await http.get(
      callUrl,
      headers: {"Authorization": "Bearer $token"},
    );

    return json.decode(response.body);
  }

  Future<http.Response> postData(String url, Map<String, String> body) async {
    String token = await storage.read(key: "token");
    var callUrl = Uri.parse('$baseURL/$url');

    var response = await http.post(
      callUrl,
      body: json.encode(body),
      headers: {"Content-type": "application/json", "Authorization": "Bearer $token"},
    );

//    print(response.body);
    return (response);
  }

  // Add Image on Profile
  Future<http.StreamedResponse> patchImage(String url, String filePath) async {
    String token = await storage.read(key: "token");
    var callUrl = Uri.parse('$baseURL/$url');

    var request = http.MultipartRequest('PATCH', callUrl);
    request.files.add(await http.MultipartFile.fromPath("img", filePath));
    request.headers.addAll({
      "Content-type": "multipart/form-data",
      "Authorization": "Bearer $token",
    });

    var response = request.send();
    return response;
  }

  NetworkImage getImage(String username) {
    String imageUrl = '$baseURL/uploads/$username.jpg';
    return NetworkImage(imageUrl);
  }

  NetworkImage getCoverImage(String username) {
    String imageUrl = '$baseURL/uploads/postCoverImages/$username.jpg';
    return NetworkImage(imageUrl);
  }

  Future<http.Response> patchData(String url, Map<String, String> body) async {
    String token = await storage.read(key: "token");
    var callUrl = Uri.parse('$baseURL/$url');

    var response = await http.patch(
      callUrl,
      body: json.encode(body),
      headers: {"Content-type": "application/json", "Authorization": "Bearer $token"},
    );

    return (response);
  }
// http://192.168.43.41:8000/
}
