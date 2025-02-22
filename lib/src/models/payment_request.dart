import 'package:json_annotation/json_annotation.dart';

part 'payment_request.g.dart';

@JsonSerializable()
class PaymentRequest {
  final String amount;
  final String? description;
  final String? statusCallbackUrl;
  final String? expiresIn;
  final String? category;
  final String? refundableFor;

  PaymentRequest({
    required this.amount,
    this.description,
    this.statusCallbackUrl,
    this.expiresIn,
    this.category,
    this.refundableFor,
  });

  factory PaymentRequest.fromJson(Map<String, dynamic> json) =>
      _$PaymentRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentRequestToJson(this);
}