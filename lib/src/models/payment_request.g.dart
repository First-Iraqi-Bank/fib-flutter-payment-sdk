// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentRequest _$PaymentRequestFromJson(Map<String, dynamic> json) =>
    PaymentRequest(
      amount: json['amount'] as String,
      description: json['description'] as String,
      statusCallbackUrl: json['statusCallbackUrl'] as String,
      expiresIn: json['expiresIn'] as String?,
      category: json['category'] as String?,
      refundableFor: json['refundableFor'] as String?,
    );

Map<String, dynamic> _$PaymentRequestToJson(PaymentRequest instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'description': instance.description,
      'statusCallbackUrl': instance.statusCallbackUrl,
      'expiresIn': instance.expiresIn,
      'category': instance.category,
      'refundableFor': instance.refundableFor,
    };
