import 'package:json_annotation/json_annotation.dart';
// import 'dart:convert';

part 'payment_response.g.dart';

@JsonSerializable()
class PaymentResponse {
  final String paymentId;
  final String qrCode;
  final String readableCode;
  final String businessAppLink;
  final String corporateAppLink;
  final String validUntil;

  PaymentResponse({
   required this.paymentId,
    required this.qrCode,
    required this.readableCode,
    required this.businessAppLink,
    required this.corporateAppLink,
    required this.validUntil,
  });

  factory PaymentResponse.fromJson(Map<String, dynamic> json) {
    return PaymentResponse(
      paymentId: json['paymentId'] ?? '',
      qrCode: json['qrCode'] ?? '',
      readableCode: json['readableCode'] ?? '',
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
      'businessAppLink': businessAppLink,
      'corporateAppLink': corporateAppLink,
      'validUntil': validUntil,
    };
  }
}