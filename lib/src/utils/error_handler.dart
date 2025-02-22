import 'package:http/http.dart' as http;
import 'dart:convert';

class ErrorHandler {
  static dynamic handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.statusCode == 204 || response.statusCode == 202){
        return;
      }
      return jsonDecode(response.body);
    } 
  }
}