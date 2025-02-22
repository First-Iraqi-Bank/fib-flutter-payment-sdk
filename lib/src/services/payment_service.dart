import 'package:fib_online_payment/src/models/payment_request.dart';
import 'package:fib_online_payment/src/models/payment_response.dart';
import 'package:fib_online_payment/src/models/payment_status.dart';
import 'package:fib_online_payment/src/utils/constants.dart';
import 'package:fib_online_payment/src/services/api_service.dart';

class PaymentService {

  final ApiService _apiService = ApiService();

  Future<PaymentResponse> createPayment(PaymentRequest request, String token, String environment) async {
      
     final body = {
      "monetaryValue": {
        "amount": request.amount,
        "currency": Constants.currency,
      },
      "statusCallbackUrl": request.statusCallbackUrl ?? "https://URL_TO_UPDATE_YOUR_PAYMENT_STATUS",
      "description": request.description ?? "FIB Payment",
      "expiresIn":  request.expiresIn ?? "PT8H6M12.345S",
      "category": request.category ?? "POS",
      "refundableFor": request.refundableFor ?? "PT48H",
    };

    final response = await _apiService.post(
      'https://fib.$environment.fib.iq/protected/v1/payments',
      {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body,
    );
    return PaymentResponse.fromJson(response);
  }

  Future<PaymentStatus> checkPaymentStatus(String paymentId, String token, String environment) async {
    final response = await _apiService.get(
      'https://fib.$environment.fib.iq/protected/v1/payments/$paymentId/status',
      {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    
    return PaymentStatus.fromJson(response);
  }

  Future<void> cancelPayment(String paymentId, String token, String environment) async {
    await _apiService.post(
      'https://fib.$environment.fib.iq/protected/v1/payments/$paymentId/cancel',
      {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      {},
    );
  }

  Future<void> refundPayment(String paymentId, String token, String environment) async {
   await _apiService.post(
      'https://fib.$environment.fib.iq/protected/v1/payments/$paymentId/refund',
      {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      {},
    );
  }
}