import 'package:json_annotation/json_annotation.dart';

part 'payment_request.g.dart';

@JsonSerializable()
class PaymentRequest {
  final String amount;
  final String description;
  final String statusCallbackUrl;
  final String? redirectUri;
  final String? expiresIn;
  final String? refundableFor;

  PaymentRequest({
    required this.amount,
    required this.description,
    required this.statusCallbackUrl,
    this.redirectUri,
    this.expiresIn,
    this.refundableFor,
  });

  factory PaymentRequest.fromJson(Map<String, dynamic> json) =>
      _$PaymentRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentRequestToJson(this);
}
