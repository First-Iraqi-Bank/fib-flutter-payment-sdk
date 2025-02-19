# FIB Online Payment
A Flutter package for handling FIB Online Payments securely and efficiently.

## Features

- **Authentication:** Verifies your credentials to ensure that only authorized users can perform transactions. This step secures the payment process from the very beginning.
- **Create Payment:** Initiates a new payment transaction by accepting details like amount, currency, and description. It handles the process securely and efficiently.
- **Cancel Payment:** Allows you to cancel a payment that is in progress or pending. This feature is useful if you need to stop a transaction before it completes.
- **Check Payment Status:** Provides real-time updates on the state of a payment, letting you know whether it is UNPAID, PAID, or DECLIEND.
- **Refund Payment:** Facilitates the reversal of a transaction by refunding the payment back to the payer. This is essential for handling cases of overcharge or cancellation after payment processing.

## Installation
Add this package to your pubspec.yaml:

```yaml
dependencies:
  fib_online_payment: latest_version
```

Then, run:

```sh
flutter pub get
```

## Usage
```dart
import 'package:flutter/material.dart';
import 'package:fib_online_payment/fib_online_payment.dart';
import 'package:fib_online_payment/src/models/payment_request.dart';
import 'package:fib_online_payment/src/models/payment_status.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final FibPayment fibPayment;

  // Pass your credentials through the constructor.
  MyApp() : fibPayment = FibPayment(
    clientId: 'your_client_id',
    clientSecret: 'your_client_secret',
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('FIB Online Payment Example')),
        body: Center(
          child: ElevatedButton(
            onPressed: () async {
              try {
                // Authenticate before performing any operations.
                await fibPayment.authenticate();
                
                // Create a payment.
                final payment = await fibPayment.createPayment(
                  PaymentRequest(
                    amount: '100.00',
                    currency: 'USD',
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
                
                // Refund payment example.
                await fibPayment.refundPayment(payment.paymentId);
                print('Payment Refunded');
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
```

## Refund Example
```dart
void refundPaymentExample() async {
  try {
    final FibPayment fibPayment = FibPayment(
      clientId: 'your_client_id',
      clientSecret: 'your_client_secret',
    );

    await fibPayment.authenticate();
    final paymentId = 'your_payment_id'; // Replace with a valid payment ID

    await fibPayment.refundPayment(paymentId);
    print('Payment Refunded');
  } catch (e) {
    print('Refund Error: $e');
  }
}
```

## Running Tests
Run the tests using:

```sh
flutter test
```

## License
This project is licensed under the MIT License.