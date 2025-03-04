import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/error_handler.dart';

class ApiService {
  Future<dynamic> post(
      String endpoint, Map<String, String> headers, dynamic body) async {
    final String? contentType = headers['Content-Type'];
    dynamic encodedBody;
    if (contentType == 'application/x-www-form-urlencoded') {
      encodedBody = Uri(queryParameters: body as Map<String, String>).query;
    } else {
      encodedBody = jsonEncode(body);
    }
    final response = await http.post(
      Uri.parse(endpoint),
      headers: headers,
      body: encodedBody,
    );
    return ErrorHandler.handleResponse(response);
  }

  Future<dynamic> get(String endpoint, Map<String, String> headers) async {
    final response = await http.get(
      Uri.parse(endpoint),
      headers: headers,
    );
    return ErrorHandler.handleResponse(response);
  }
}
