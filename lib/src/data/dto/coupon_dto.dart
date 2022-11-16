import 'dart:convert';

import 'package:ark_module_checkout/ark_module_checkout.dart';

CouponDTO couponFromJson(String str) => CouponDTO.fromJson(json.decode(str));

class CouponDTO extends CouponEntity {
  CouponDTO({
    required super.success,
    required super.data,
  });

  factory CouponDTO.fromJson(Map<String, dynamic> json) => CouponDTO(
        success: json["success"],
        data: json["success"] == false
            ? CouponDataDTO.fromJson({})
            : CouponDataDTO.fromJson(json["data"]),
      );
}

class CouponDataDTO extends CouponDataEntity {
  CouponDataDTO({
    required super.id,
    required super.code,
    required super.amount,
    required super.discountType,
    required super.description,
    required super.dateExpires,
    required super.usageCount,
    required super.individualUse,
    required super.productIds,
    required super.usageLimit,
    required super.usageLimitPerUser,
    required super.limitUsageToXItems,
    required super.freeShipping,
    required super.excludeSaleItems,
    required super.minimumAmount,
    required super.maximumAmount,
    required super.usedBy,
  });

  factory CouponDataDTO.fromJson(Map<String, dynamic> json) => CouponDataDTO(
        id: json["id"] ?? 0,
        code: json["code"] ?? "",
        amount: json["amount"] ?? "",
        discountType: json["discount_type"] ?? "",
        description: json["description"] ?? "",
        dateExpires: json["date_expires"] ?? "",
        usageCount: json["usage_count"] ?? "0",
        individualUse: json["individual_use"] ?? "",
        productIds: json["product_ids"],
        usageLimit: json["usage_limit"] == null || json["usage_limit"] == "0"
            ? "9999"
            : json["usage_limit"],
        usageLimitPerUser: json["usage_limit_per_user"] ?? "0",
        limitUsageToXItems: json["limit_usage_to_x_items"] ?? "",
        freeShipping: json["free_shipping"] ?? "",
        excludeSaleItems: json["exclude_sale_items"] ?? "",
        minimumAmount: json["minimum_amount"] ?? "",
        maximumAmount: json["maximum_amount"] ?? "",
        usedBy:
            json["used_by"] == null ? [] : List<dynamic>.from(json["used_by"]),
      );
}
