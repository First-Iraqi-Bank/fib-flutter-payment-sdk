import 'package:flutter/material.dart';
import 'package:fib_online_payment/fib_online_payment.dart';
import 'package:fib_online_payment/src/models/payment_request.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final clientId = 'YOUR_CLIENT_ID';
  final clientSecret = 'YOUR_CLIENT_SECRET';
  final environment = 'YOUR_ENVIRONMENT'; // dev, stage or prod
  final FibPayment fibPayment = FibPayment(clientId: 'YOUR_CLIENT_ID', clientSecret: 'YOUR_CLIENT_SECRET', environment: 'YOUR_ENVIRONMENT');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('FIB Online Payment Example')),
        body: Center(
          child: ElevatedButton(
            onPressed: () async {
              try {
                final token = await fibPayment.authenticate();
                final payment = await fibPayment.createPayment(
                  PaymentRequest(
                    amount: '100.00',
                    description: 'Test Payment',
                    statusCallbackUrl: 'https://your-callback-url.com'
                  ),
                  token,
                );
                print(token);

                print('Payment Created: ${payment.paymentId}');
                print('Payment QR Code: ${payment.qrCode}');
                print('Payment readable code: ${payment.readableCode}');

                // Check payment status.
                final status = await fibPayment.checkPaymentStatus(payment.paymentId, token);
                print('Payment Status: ${status.status}');

                // Cancel payment example.
                await fibPayment.cancelPayment(payment.paymentId, token);
                await Future.delayed(Duration(seconds: 5)); // Wait for cancellation to process.
                final postCancelStatus = await fibPayment.checkPaymentStatus(payment.paymentId, token);
                print('Post Cancel Status: ${postCancelStatus.status}');
              } catch (e) {
                print('Error: $e');
              }
            },
            child: Text('Process Payment'),
          ),
        ),
      ),
    );
  }
}
