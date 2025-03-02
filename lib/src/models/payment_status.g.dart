// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentStatus _$PaymentStatusFromJson(Map<String, dynamic> json) =>
    PaymentStatus(
      paymentId: json['paymentId'] as String,
      status: json['status'] as String,
    );

Map<String, dynamic> _$PaymentStatusToJson(PaymentStatus instance) =>
    <String, dynamic>{
      'paymentId': instance.paymentId,
      'status': instance.status,
    };
