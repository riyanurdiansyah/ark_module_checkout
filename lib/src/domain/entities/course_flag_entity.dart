class CourseFlagEntity {
  CourseFlagEntity({
    required this.whatsapp,
    required this.prakerja,
    required this.revamp,
    required this.jrc,
    required this.group,
  });

  final String whatsapp;
  final String prakerja;
  final String revamp;
  final String jrc;
  final String group;

  CourseFlagEntity copyWith({
    String? whatsapp,
    String? prakerja,
    String? revamp,
    String? jrc,
    String? group,
  }) =>
      CourseFlagEntity(
        whatsapp: whatsapp ?? this.whatsapp,
        prakerja: prakerja ?? this.prakerja,
        revamp: revamp ?? this.revamp,
        jrc: jrc ?? this.jrc,
        group: group ?? this.group,
      );

  Map<String, dynamic> toJson() => {
        "whatsapp": whatsapp,
        "prakerja": prakerja,
        "revamp": revamp,
        "jrc": jrc,
        "group": group,
      };
}
