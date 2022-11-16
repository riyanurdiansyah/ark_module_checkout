import 'dart:convert';

import 'package:ark_module_checkout/src/domain/entities/payment_method_entity.dart';

List<PaymentMethodDTO> paymentFromJson(String str) =>
    List<PaymentMethodDTO>.from(
        json.decode(str).map((x) => PaymentMethodDTO.fromJson(x)));

class PaymentMethodDTO extends PaymentMethodEntity {
  PaymentMethodDTO({
    required super.chanel,
    required super.code,
    required super.description,
    required super.id,
    required super.image,
    required super.limit,
    required super.status,
    required super.tipe,
    required super.title,
    required super.titleType,
  });

  factory PaymentMethodDTO.fromJson(Map<String, dynamic> json) =>
      PaymentMethodDTO(
        chanel: json['chanel'] ?? "",
        code: json['code'] ?? "",
        description: json['description'] ?? "",
        id: json['id'] ?? 99,
        image: json['image'] ?? "",
        limit: json['limit'] ?? 0,
        status: json['status'] ?? false,
        tipe: json['tipe'] ?? 0,
        title: json['title'] ?? "",
        titleType: json['title_type'] ?? "",
      );
}
