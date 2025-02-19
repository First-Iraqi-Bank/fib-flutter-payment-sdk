import 'package:http/http.dart' as http;
import 'dart:convert';

class ErrorHandler {
  static dynamic handleResponse(http.Response response) {
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } 
  }
}