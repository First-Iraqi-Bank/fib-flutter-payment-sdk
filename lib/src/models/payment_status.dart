import 'package:json_annotation/json_annotation.dart';

part 'payment_status.g.dart';

@JsonSerializable()
class PaymentStatus {
  final String paymentId;
  final String status;

  PaymentStatus({
    required this.paymentId,
    required this.status,
  });

  factory PaymentStatus.fromJson(Map<String, dynamic> json) =>
      _$PaymentStatusFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentStatusToJson(this);
}
