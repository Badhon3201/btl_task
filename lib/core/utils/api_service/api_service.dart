import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ApiService {
  http.Client? httClient;

  ApiService({this.httClient}) {
    httClient ??= http.Client();
  }

  Future<http.Response> getRequest(String url) async {
    var completeUrl = url;
    debugPrint("Checking for Get API start & end point $completeUrl");
    var headers = {'Content-Type': 'application/json'};
    return httClient!.get(Uri.parse(completeUrl), headers: headers);
  }

  Future<http.Response> postRequest(
      String url, Map<String, dynamic> body) async {
    var completeUrl = url;
    debugPrint("Checking for Post API start & end point $completeUrl");
    var headers = {'Content-Type': 'application/json'};
    var encodedBody = json.encode(body);

    return httClient!
        .post(Uri.parse(completeUrl), headers: headers, body: encodedBody);
  }

  Future<http.Response> putRequest(String url, Map<String, dynamic> body,
      {Duration? timeout}) async {
    var completeUrl = url;
    debugPrint("Checking for Put API start & end point $completeUrl");
    var headers = {'Content-Type': 'application/json'};
    var encodedBody = json.encode(body);
    return httClient!
        .put(Uri.parse(completeUrl), headers: headers, body: encodedBody);
  }
}
