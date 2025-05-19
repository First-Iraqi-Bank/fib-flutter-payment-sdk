import 'package:fib_online_payment/src/services/api_service.dart';

class AuthService {
  final ApiService _apiService = ApiService();

  Future<String> authenticate(
      String clientId, String clientSecret, String environment) async {
    final body = {
      'grant_type': 'client_credentials',
      'client_id': clientId,
      'client_secret': clientSecret,
    };
    final response = await _apiService.post(
      'https://fib-$environment.fib.iq/auth/realms/fib-online-shop/protocol/openid-connect/token',
      {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body,
    );
    return response['access_token'];
  }
}
