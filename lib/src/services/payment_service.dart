import 'package:fib_online_payment/src/models/payment_request.dart';
import 'package:fib_online_payment/src/models/payment_response.dart';
import 'package:fib_online_payment/src/models/payment_status.dart';
import 'package:fib_online_payment/src/services/api_service.dart';
import 'package:fib_online_payment/src/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class PaymentService {
  final ApiService _apiService = ApiService(baseUrl: Constants.baseUrl);

  Future<PaymentResponse> createPayment(PaymentRequest request, String token) async {

     final Map<String, dynamic> staticRequestData = {
      "monetaryValue": {
        "amount": request.amount,
        "currency": request.currency,
      },
      "statusCallbackUrl": "https://URL_TO_UPDATE_YOUR_PAYMENT_STATUS",
      "description": request.description
    };

     final response = await http.post(
      Uri.parse(Constants.baseUrl + '/protected/v1/payments'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(staticRequestData),
    );
   
    if (response.statusCode == 200 || response.statusCode == 201) {
      if (response.body.isNotEmpty) {
          return PaymentResponse.fromJson(jsonDecode(response.body));
      } else {
          throw Exception('Empty response body');
        }
      } else {
        throw Exception('Failed to create payment: ${response.statusCode} ${response.body}');
    }
  }

  Future<PaymentStatus> checkPaymentStatus(String paymentId, String token) async {
    final response = await http.get(
      Uri.parse(Constants.baseUrl + '/protected/v1/payments/$paymentId/status'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
      if (response.body.isNotEmpty) {
          return PaymentStatus.fromJson(jsonDecode(response.body));
      } else {
          throw Exception('Empty response body');
        }
      } else {
        throw Exception('Failed to check payment: ${response.statusCode} ${response.body}');
    }
  }

  Future<void> cancelPayment(String paymentId, String token) async {
    final response = await http.post(
      Uri.parse(Constants.baseUrl + '/protected/v1/payments/$paymentId/cancel'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 204) {
        return;
      } else {
        throw Exception('Failed to cancel payment: ${response.statusCode} ${response.body}');
      }
  }

  Future<void> refundPayment(String paymentId, String token) async {
    final response = await http.post(
      Uri.parse(Constants.baseUrl + '/protected/v1/payments/$paymentId/refund'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      });
      
      if (response.statusCode == 202) {
        return;
      } else {
        throw Exception('Failed to refund payment: ${response.statusCode} ${response.body}');
      }

  }
}