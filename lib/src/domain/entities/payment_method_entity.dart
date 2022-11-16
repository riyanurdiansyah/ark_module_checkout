class PaymentMethodEntity {
  final String chanel;
  final String code;
  final String description;
  final int id;
  final String image;
  final int limit;
  final bool status;
  final int tipe;
  final String title;
  final String titleType;

  PaymentMethodEntity({
    required this.chanel,
    required this.code,
    required this.description,
    required this.id,
    required this.image,
    required this.limit,
    required this.status,
    required this.tipe,
    required this.title,
    required this.titleType,
  });

  PaymentMethodEntity copyWith({
    String? chanel,
    String? code,
    String? description,
    int? id,
    String? image,
    int? limit,
    bool? status,
    int? tipe,
    String? title,
    String? titleType,
  }) =>
      PaymentMethodEntity(
        chanel: chanel ?? this.chanel,
        code: code ?? this.code,
        description: description ?? this.description,
        id: id ?? this.id,
        image: image ?? this.image,
        limit: limit ?? this.limit,
        status: status ?? this.status,
        tipe: tipe ?? this.tipe,
        title: title ?? this.title,
        titleType: titleType ?? this.titleType,
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['chanel'] = chanel;
    data['code'] = code;
    data['description'] = description;
    data['id'] = id;
    data['image'] = image;
    data['limit'] = limit;
    data['status'] = status;
    data['tipe'] = tipe;
    data['title'] = title;
    data['title_type'] = titleType;
    // data['use_snap'] = useSnap;
    return data;
  }
}
