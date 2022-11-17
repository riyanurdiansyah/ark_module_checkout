import 'package:ark_module_checkout/src/domain/entities/waiting_order_entity.dart';

class WaitingOrderDTO extends WaitingOrderEntity {
  WaitingOrderDTO({
    required super.success,
    required super.data,
  });

  factory WaitingOrderDTO.fromJson(Map<String, dynamic> json) =>
      WaitingOrderDTO(
        success: json["success"],
        data: json["success"] == false
            ? DataWaitingOrderDTO(
                orderTotal: "0",
                mtPaymentUrl: "",
                createdAt: "",
                discountTotal: 0,
                status: "")
            : DataWaitingOrderDTO.fromJson(json["data"]),
      );
}

class DataWaitingOrderDTO extends DataWaitingOrderEntity {
  DataWaitingOrderDTO({
    required super.orderTotal,
    required super.mtPaymentUrl,
    required super.createdAt,
    required super.discountTotal,
    required super.status,
  });

  factory DataWaitingOrderDTO.fromJson(Map<String, dynamic> json) =>
      DataWaitingOrderDTO(
        orderTotal: json['total'],
        status: json['status'] ?? "",
        mtPaymentUrl: json['mt_payment_url'] ?? "",
        createdAt: json['date_created'] ?? DateTime.now().toIso8601String(),
        discountTotal: json['discount_total'],
      );
}
