class WaitingOrderEntity {
  final bool success;
  final DataWaitingOrderEntity data;

  WaitingOrderEntity({required this.success, required this.data});
}

class DataWaitingOrderEntity {
  final String orderTotal;
  final String mtPaymentUrl;
  final String createdAt;
  final int discountTotal;
  final String status;

  DataWaitingOrderEntity({
    required this.orderTotal,
    required this.mtPaymentUrl,
    required this.createdAt,
    required this.discountTotal,
    required this.status,
  });
}
