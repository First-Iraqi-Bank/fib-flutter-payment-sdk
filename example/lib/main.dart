import 'package:flutter/material.dart';
import 'package:fib_online_payment/fib_online_payment.dart';
import 'package:fib_online_payment/src/models/payment_request.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final FibPayment fibPayment = FibPayment(clientId: 'elec-top-up', clientSecret: '996ed63f-e36f-43ad-851b-42bcfecc792c');

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
                    currency: 'IQD',
                    description: 'Test Payment',
                  ),
                  token,
                );
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
