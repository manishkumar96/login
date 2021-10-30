import 'dart:convert';
import 'dart:io';

import 'package:login/resource_helper/strings.dart';
import 'package:http/http.dart' as http;

class HttpHelper {
  static final HttpHelper _getInstance = HttpHelper._internal();

  HttpHelper._internal();

  factory HttpHelper() {
    return _getInstance;
  }

  Future<Map?> post({required String url, required String? body}) async {
    StringHelper.printValue('API URL: ' + url);
    StringHelper.printValue('API BODY: ' + body!);

    var apiHeaders = {"content-type": "application/json"};

    var responseData;
    try {
      final apiResponse =
          await http.post(Uri.parse(url), body: body, headers: apiHeaders);
      Map<String, String> headers = apiResponse.headers;
      StringHelper.printValue("HEADERS : " + headers.toString());
      StringHelper.printValue(
          "STATUS CODE : " + apiResponse.statusCode.toString());
      StringHelper.printValue("BODY :" + apiResponse.body.toString());
      responseData = returnResponseData(response: apiResponse);
    } on SocketException {
      return null;
    }
    return responseData;
  }

  returnResponseData({required http.Response response}) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        return responseJson;

      case 400:
        print("Bad Request Exception" + response.body.toString());
        break;

      case 401:
        print("UnAuthorisedException" + response.body.toString());
    }
  }
}
