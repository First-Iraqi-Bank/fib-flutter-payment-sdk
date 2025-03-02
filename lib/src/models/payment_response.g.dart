// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentResponse _$PaymentResponseFromJson(Map<String, dynamic> json) =>
    PaymentResponse(
      paymentId: json['paymentId'] as String,
      qrCode: json['qrCode'] as String,
      readableCode: json['readableCode'] as String,
      personalAppLink: json['personalAppLink'] as String,
      businessAppLink: json['businessAppLink'] as String,
      corporateAppLink: json['corporateAppLink'] as String,
      validUntil: json['validUntil'] as String,
    );

Map<String, dynamic> _$PaymentResponseToJson(PaymentResponse instance) =>
    <String, dynamic>{
      'paymentId': instance.paymentId,
      'qrCode': instance.qrCode,
      'readableCode': instance.readableCode,
      'personalAppLink': instance.personalAppLink,
      'businessAppLink': instance.businessAppLink,
      'corporateAppLink': instance.corporateAppLink,
      'validUntil': instance.validUntil,
    };
