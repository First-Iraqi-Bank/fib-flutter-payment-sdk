# FIB Online Payment
A Flutter package for handling FIB Online Payments securely and efficiently.

## Features
- **Authentication:** Verifies client credentials to generate access tokens.
- **Create Payment:** Initiates payments with flexible parameters and defaults.
- **Check Payment Status:** Retrieves real-time payment status updates.
- **Cancel Payment:** Cancels pending/unpaid transactions.
- **Refund Payment:** Processes refunds for completed transactions.

## Installation
Add to `pubspec.yaml`:
```yaml
dependencies:
  fib_online_payment: ^1.0.1
```
Then, run:
```sh
flutter pub get
```

### Service Initialization
```dart
final fibPayment = FibPayment(
  clientId: 'elec-top-up',       // Your application/client ID
  clientSecret: 'your-secret',   // Client Secret key for authentication
  environment: 'dev',            // API environment: dev/stage/prod
);
```

#### Parameter Descriptions:
| Parameter      | Required | Description                                         |
|----------------|----------|-----------------------------------------------------|
| `clientId`     | Yes      | Unique client ID.              |
| `clientSecret` | Yes      | Unique client Secret key.                |
| `environment`  | Yes      | Determines API endpoint (dev, stage, or prod)       |

---

### Payment Request Parameters
When creating payments using `PaymentRequest`:
```dart
PaymentRequest(
  amount: '100.00',                  // Required: Transaction amount
  description: 'Test Payment',       // Required: Human-readable description
  statusCallbackUrl: 'your-url',     // Required: A callback URL
  redirectUri: 'your-redirect-uri',  // Optional: Used to redirect to a specified add or web URL after the payment is done.
  expiresIn: 'PT1H',                 // Optional: expiration duration
  category: 'POS',                   // Optional: Payment category
  refundableFor: 'PT24H',            // Optional: Refund time
);
```

#### Parameter Details:
| Parameter           | Required | Default Value         | Description                                         |
|---------------------|----------|-----------------------|-----------------------------------------------------|
| `amount`            | Yes      | -                     | Transaction amount as string (e.g., '100.00')       |
| `description`       | Yes      | 'FIB Payment'         | Payment description shown to users                  |
| `statusCallbackUrl` | Yes      | Platform-default URL  | A callback URL             |
| `redirectUri`       | No       | Null                  | A redirect URL used to redirect the user after the payment is done.             |
| `expiresIn`         | No       | 'PT8H6M12.345S'       | Duration until payment expiration          |
| `category`          | No       | 'POS'                 | Payment category (e.g., POS) |
| `refundableFor`     | No       | 'PT48H' (48 hours)    | duration for refund eligibility            |

---

## Feature Examples

### 1. Create Payment
```dart
final payment = await fibPayment.createPayment(
  PaymentRequest(
    amount: '50.00',
    description: 'Coffee Order',
    statusCallbackUrl: 'https://your-app.com/callback',
    redirectUri: 'https://your-app.com',
    expiresIn: 'PT12H', // Expires in 12 hours
    category: 'POS',
  ),
  token,
);
// Returns: 
// PaymentResponse{
//   paymentId: 'PAY-123', 
//   qrCode: '...', 
//   readableCode: '1234-5678',
//   personalAppLink: 'https://personal.dev.first-iraqi-bank.co...', 
//   businessAppLink: 'https://business.dev.first-iraqi-bank.co...', 
//   corporateAppLink: 'https://corporate.dev.first-iraqi-bank.co...',
//   validUntil: '2025-03-05T11:46:24.181Z',
// }
```
### 2. Check Payment Status
```dart
final status = await fibPayment.checkPaymentStatus('PAY-123', token);
// Returns: 
// PaymentStatus{
//   paymentId: 'PAY-123',
//   status: 'PAID',
// }
```

### 3. Cancel Payment
```dart
await fibPayment.cancelPayment('PAY-123', token);
// Successful cancellation returns HTTP 204 (No Content)
```

### 4. Refund Payment
```dart
await fibPayment.refundPayment('PAY-123', token);
// Successful refund initiation returns HTTP 202 (Accepted)
```

---

## Response Models

### PaymentResponse
```dart
{
  "paymentId": "PAY-123",                                              // Unique payment identifier
  "qrCode": "base64-image-data",                                       // QR code for payment scanning
  "readableCode": "1234-5678",                                         // Human-friendly payment code
  "personalAppLink": 'https://personal.dev.first-iraqi-bank.co...',    // Personal App link
  "businessAppLink": 'https://business.dev.first-iraqi-bank.co...',    // Business App link
  "corporateAppLink": 'https://corporate.dev.first-iraqi-bank.co...',  // Corporate App link
  "validUntil": '2025-03-05T11:46:24.181Z',                            // Payment validity
}
```

### PaymentStatus
```dart
{
  "paymentId": "PAY-123",         // Original payment ID
  "status": "PAID",               // Current status
  "updatedAt": "ISO-8601-time"    // Last status update timestamp
}
```

---

## Error Handling
Wrap operations in try-catch blocks:
```dart
try {
  // Payment operations
} catch (e) {
  print('Error: ${e.toString()}');
  // Example error: "API Error: 401 - Invalid credentials"
}
```

---

## Full Example Usage
```dart
import 'package:flutter/material.dart';
import 'package:fib_online_payment/fib_online_payment.dart';
import 'package:fib_online_payment/src/models/payment_request.dart';
import 'package:fib_online_payment/src/models/payment_status.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Pass your credentials through the constructor.
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
                // Authenticate before performing any operations.
                await fibPayment.authenticate();
                
                // Create a payment.
                final payment = await fibPayment.createPayment(
                  PaymentRequest(
                    amount: '100.00',
                    description: 'Test Payment',
                    statusCallbackUrl: 'https://your-callback-url.com',
                    redirectUri: 'https://your-redirect-url.com'
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

## License
This project is licensed under the Apache License 2.0. See the [LICENSE](LICENSE) file for details.
