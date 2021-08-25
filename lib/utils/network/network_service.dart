import 'dart:convert';
import 'dart:io';

import 'package:funda_sample/data/repository/local/app_preferences.dart';
import 'package:funda_sample/resources/resources.dart';
import 'package:funda_sample/utils/network/exception.dart';
import 'package:http/http.dart' as http;

class NetworkService {
  Future<dynamic> get(
      {required String url,
      Map<String, String>? headers,
      Map<String, String>? queries}) async {
    headers?.addAll({'Accept-Language': AppPreferences.getLocale()});
    var response;
    var uri = Uri.parse(url);
    try {
      response = _returnResponse(await http.get(uri, headers: headers));
    } on SocketException {
      throw FetchDataException(Resources.getString('general__no_internet'));
    }
    return response;
  }

  Future<dynamic> post(
      {required String url,
      Map<String, String>? headers,
      Map<String, dynamic>? body}) async {
    headers?.addAll({'Accept-Language': AppPreferences.getLocale()});
    var response;
    var uri = Uri.parse(url);
    try {
      response = _returnResponse(
          await http.post(uri, headers: headers, body: json.encode(body)));
    } on SocketException {
      throw FetchDataException(Resources.getString('general__no_internet'));
    }
    return response;
  }

  Future<dynamic> put(
      {required String url,
      Map<String, String>? headers,
      Map<String, dynamic>? body}) async {
    headers?.addAll({'Accept-Language': AppPreferences.getLocale()});
    var response;
    var uri = Uri.parse(url);
    try {
      response = _returnResponse(
          await http.put(uri, headers: headers, body: json.encode(body)));
    } on SocketException {
      throw FetchDataException(Resources.getString('general__no_internet'));
    }
    return response;
  }

  Future<dynamic> delete(
      {required String url,
      Map<String, String>? headers,
      Map<String, dynamic>? body}) async {
    headers?.addAll({'Accept-Language': AppPreferences.getLocale()});
    var response;
    var uri = Uri.parse(url);
    try {
      response = _returnResponse(
          await http.delete(uri, headers: headers, body: json.encode(body)));
    } on SocketException {
      throw FetchDataException(Resources.getString('general__no_internet'));
    }
    return response;
  }

  http.Response _returnResponse(http.Response response) {
    print(
        'response code ${response.statusCode} body ${response.body.toString()} reason ${response.reasonPhrase}');
    switch (response.statusCode) {
      case 200:
      case 201:
      case 204:
        if (response.body.isNotEmpty) {
          var responseJson = json.decode(response.body.toString());
          print(responseJson);
        }
        return response;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
        {
          throw UnauthorisedException(response.body.toString());
        }
      case 403:
        {
          throw UnauthorisedException(response.body.toString());
        }
      case 500:
      default:
        throw FetchDataException(Resources.getStringWithPlaceholder(
            'general__server_error', [response.statusCode.toString()]));
    }
  }
}
