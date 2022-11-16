class CourseCoinEntity {
  CourseCoinEntity({
    required this.coinFlag,
    required this.coinDescription,
    required this.coinValue,
  });

  final String coinFlag;
  final String coinValue;
  final String coinDescription;

  Map<String, dynamic> toJson() => {
        "coin_flag": coinFlag,
        "coin_value": coinValue,
        "coin_description": coinDescription,
      };
}
