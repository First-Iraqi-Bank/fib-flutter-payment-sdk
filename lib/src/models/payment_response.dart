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

  factory PaymentResponse.fromJson(Map<String, dynamic> json) =>
      _$PaymentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentResponseToJson(this);
}