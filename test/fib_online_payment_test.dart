import 'package:flutter_test/flutter_test.dart';
import 'package:fib_online_payment/fib_online_payment.dart';
import 'package:fib_online_payment/src/models/payment_request.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:io';


void main() {
  group('Payment Tests', () {
    late FibPayment fibPayment;
    late String token;
    late String paymentId;

    setUpAll(() async {
      // Get the absolute path of .env file
      final envFilePath = File('.env').absolute.path;

      // Ensure the .env file exists
      if (!File(envFilePath).existsSync()) {
        throw Exception('.env file not found at: $envFilePath');
      }

      // Load environment variables
      await dotenv.load(fileName: envFilePath);

      // Get client ID & secret from .env
      final String clientId = dotenv.env['CLIENT_ID'] ?? '';
      final String clientSecret = dotenv.env['CLIENT_SECRET'] ?? '';
      final String environment = 'dev';

      fibPayment = FibPayment(clientId: clientId, clientSecret: clientSecret, environment: environment);

      token = await fibPayment.authenticate();
    });

    test('Create Payment', () async {
      final payment = await fibPayment.createPayment(
        PaymentRequest(
          amount: '100.00',
          description: 'Test Payment',
          statusCallbackUrl : 'https://localhost:3000'
        ),
        token,
      );
      expect(payment.paymentId, isNotNull);
      paymentId = payment.paymentId;
    });

    test('Check Payment Status', () async {
      final status = await fibPayment.checkPaymentStatus(paymentId, token);
      expect(status.status, isNotNull);
      expect(status.status, anyOf(['PAID', 'UNPAID', 'DECLINED']));
    });

    test('Cancel Payment', () async {
      final payment = await fibPayment.createPayment(
        PaymentRequest(
          amount: '500.00',
          description: 'Test Cancel Payment',
          statusCallbackUrl : 'https://fib.dev.fib.iq'
        ),
        token,
      );

      expect(payment.paymentId, isNotNull);

      final String cancelPaymentId = payment.paymentId;

      await fibPayment.cancelPayment(cancelPaymentId, token);
      await Future.delayed(Duration(seconds: 5));
      final postCancelStatus = await fibPayment.checkPaymentStatus(cancelPaymentId, token);
      expect(postCancelStatus.status, 'DECLINED');
    });


    // test('Refund Payment', () async {
    //   final response = await fibPayment.refundPayment(paymentId, token);
    // });

  });
}
