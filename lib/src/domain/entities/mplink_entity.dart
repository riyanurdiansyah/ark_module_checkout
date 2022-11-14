class MpLinkEntity {
  MpLinkEntity({
    required this.mpName,
    required this.mpLogo,
    required this.mpProdukLink,
  });

  final String mpName;
  final String mpLogo;
  final String mpProdukLink;

  Map<String, dynamic> toJson() => {
        "mp_name": mpName,
        "mp_logo": mpLogo,
        "mp_produk_link": mpProdukLink,
      };
}
