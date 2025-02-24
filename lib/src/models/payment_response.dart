import 'package:json_annotation/json_annotation.dart';

part 'payment_response.g.dart';

@JsonSerializable()
class PaymentResponse {
  final String paymentId;
  final String qrCode;
  final String readableCode;
  final String personalAppLink;
  final String businessAppLink;
  final String corporateAppLink;
  final String validUntil;

  PaymentResponse({
   required this.paymentId,
    required this.qrCode,
    required this.readableCode,
    required this.personalAppLink,
    required this.businessAppLink,
    required this.corporateAppLink,
    required this.validUntil,
  });

  factory PaymentResponse.fromJson(Map<String, dynamic> json) {
    return PaymentResponse(
      paymentId: json['paymentId'] ?? '',
      qrCode: json['qrCode'] ?? '',
      readableCode: json['readableCode'] ?? '',
      personalAppLink: json['personalAppLink'] ?? '',
      businessAppLink: json['businessAppLink'] ?? '',
      corporateAppLink: json['corporateAppLink'] ?? '',
      validUntil: json['validUntil'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'paymentId': paymentId,
      'qrCode': qrCode,
      'readableCode': readableCode,
      'personalAppLink': personalAppLink,
      'businessAppLink': businessAppLink,
      'corporateAppLink': corporateAppLink,
      'validUntil': validUntil,
    };
  }
}