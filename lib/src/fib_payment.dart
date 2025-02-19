import 'package:fib_online_payment/src/models/payment_request.dart';
import 'package:fib_online_payment/src/models/payment_response.dart';
import 'package:fib_online_payment/src/models/payment_status.dart';
import 'package:fib_online_payment/src/services/auth_service.dart';
import 'package:fib_online_payment/src/services/payment_service.dart';

class FibPayment {
  final AuthService _authService = AuthService();
  final PaymentService _paymentService = PaymentService();

  final String clientId;
  final String clientSecret;

  FibPayment({required this.clientId, required this.clientSecret});

  Future<String> authenticate() async {
    return await _authService.authenticate(clientId, clientSecret);
  }

  Future<PaymentResponse> createPayment(PaymentRequest request, String token) async {
    return await _paymentService.createPayment(request, token);
  }

  Future<PaymentStatus> checkPaymentStatus(String paymentId, String token) async {
    return await _paymentService.checkPaymentStatus(paymentId, token);
  }

  Future<void> cancelPayment(String paymentId, String token) async {
    await _paymentService.cancelPayment(paymentId, token);
  }

  Future<void> refundPayment(String paymentId, String token) async {
    await _paymentService.refundPayment(paymentId, token);
  }
}