import 'package:fib_online_payment/src/models/payment_request.dart';
import 'package:fib_online_payment/src/models/payment_response.dart';
import 'package:fib_online_payment/src/models/payment_status.dart';
import 'package:fib_online_payment/src/utils/constants.dart';
import 'package:fib_online_payment/src/services/api_service.dart';

class PaymentService {
  final String environment;
  final ApiService _apiService = ApiService();

  String url() => 'https://fib.$environment.fib.iq/protected/v1/payments';

  PaymentService({required this.environment});

  Future<PaymentResponse> createPayment(
      PaymentRequest request, String token) async {
    final body = {
      "monetaryValue": {
        "amount": request.amount,
        "currency": Constants.currency,
      },
      "statusCallbackUrl": request.statusCallbackUrl,
      "description": request.description,
      "expiresIn": request.expiresIn ?? "PT8H6M12.345S",
      "category": request.category ?? "POS",
      "refundableFor": request.refundableFor ?? "PT48H",
    };

    final response = await _apiService.post(
      this.url(),
      {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body,
    );
    return PaymentResponse.fromJson(response);
  }

  Future<PaymentStatus> checkPaymentStatus(
      String paymentId, String token) async {
    final response = await _apiService.get(
      '${this.url()}/${paymentId}/status',
      {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    return PaymentStatus.fromJson(response);
  }

  Future<void> cancelPayment(String paymentId, String token) async {
    await _apiService.post(
      '${this.url()}/${paymentId}/cancel',
      {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      {},
    );
  }

  Future<void> refundPayment(String paymentId, String token) async {
    await _apiService.post(
      '${this.url()}/${paymentId}/refund',
      {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      {},
    );
  }
}
