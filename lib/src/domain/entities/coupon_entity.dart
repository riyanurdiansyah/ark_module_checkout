import 'dart:convert';

String couponEntityToJson(CouponEntity data) => json.encode(data.toJson());

class CouponEntity {
  CouponEntity({
    required this.success,
    required this.data,
  });

  final bool success;
  final CouponDataEntity data;

  CouponEntity copyWith({
    bool? success,
    CouponDataEntity? data,
  }) =>
      CouponEntity(
        success: success ?? this.success,
        data: data ?? this.data,
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
      };
}

class CouponDataEntity {
  CouponDataEntity({
    required this.id,
    required this.code,
    required this.amount,
    required this.discountType,
    required this.description,
    required this.dateExpires,
    required this.usageCount,
    required this.individualUse,
    required this.productIds,
    required this.usageLimit,
    required this.usageLimitPerUser,
    required this.limitUsageToXItems,
    required this.freeShipping,
    required this.excludeSaleItems,
    required this.minimumAmount,
    required this.maximumAmount,
    required this.usedBy,
  });

  int id;
  String code;
  String amount;
  String discountType;
  String description;
  String dateExpires;
  String usageCount;
  String individualUse;
  dynamic productIds;
  String usageLimit;
  String usageLimitPerUser;
  String limitUsageToXItems;
  String freeShipping;
  String excludeSaleItems;
  String minimumAmount;
  String maximumAmount;
  List<dynamic> usedBy;

  CouponDataEntity copyWith({
    int? id,
    String? code,
    String? amount,
    String? discountType,
    String? description,
    String? dateExpires,
    String? usageCount,
    String? individualUse,
    dynamic productIds,
    dynamic excludedProductIds,
    String? usageLimit,
    String? usageLimitPerUser,
    String? limitUsageToXItems,
    String? freeShipping,
    dynamic productCategories,
    dynamic excludedProductCategories,
    String? excludeSaleItems,
    String? minimumAmount,
    String? maximumAmount,
    dynamic emailRestrictions,
    List<dynamic>? usedBy,
  }) =>
      CouponDataEntity(
        id: id ?? this.id,
        code: code ?? this.code,
        amount: amount ?? this.amount,
        discountType: discountType ?? this.discountType,
        description: description ?? this.description,
        dateExpires: dateExpires ?? this.dateExpires,
        usageCount: usageCount ?? this.usageCount,
        individualUse: individualUse ?? this.individualUse,
        productIds: productIds ?? this.productIds,
        usageLimit: usageLimit ?? this.usageLimit,
        usageLimitPerUser: usageLimitPerUser ?? this.usageLimitPerUser,
        limitUsageToXItems: limitUsageToXItems ?? this.limitUsageToXItems,
        freeShipping: freeShipping ?? this.freeShipping,
        excludeSaleItems: excludeSaleItems ?? this.excludeSaleItems,
        minimumAmount: minimumAmount ?? this.minimumAmount,
        maximumAmount: maximumAmount ?? this.maximumAmount,
        usedBy: usedBy ?? this.usedBy,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "amount": amount,
        "discount_type": discountType,
        "description": description,
        "date_expires": dateExpires,
        "usage_count": usageCount,
        "individual_use": individualUse,
        "product_ids": productIds,
        "usage_limit": usageLimit,
        "usage_limit_per_user": usageLimitPerUser,
        "limit_usage_to_x_items": limitUsageToXItems,
        "free_shipping": freeShipping,
        "exclude_sale_items": excludeSaleItems,
        "minimum_amount": minimumAmount,
        "maximum_amount": maximumAmount,
        "used_by": usedBy,
      };
}
