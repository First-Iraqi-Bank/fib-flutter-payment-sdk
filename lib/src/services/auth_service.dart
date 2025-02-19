import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';

class AuthService {
  Future<String> authenticate(String clientId, String clientSecret) async {
    final response = await http.post(
      Uri.parse(Constants.baseUrl + '/auth/realms/fib-online-shop/protocol/openid-connect/token'),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'grant_type': 'client_credentials',
        'client_id': clientId,
        'client_secret': clientSecret,
      },
    );
    

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // The token is typically returned under the "access_token" key.
      return data['access_token'];
    } else {
      throw Exception('Failed to authenticate: ${response.statusCode} ${response.body}');
    }
  }
}
