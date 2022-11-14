import 'package:ark_module_checkout/ark_module_checkout.dart';

class LowonganDTO extends LowonganEntity {
  const LowonganDTO({
    super.id,
    super.courseId,
    super.jumlahLowongan,
    super.startDateLowongan,
    super.endDateLowongan,
    super.categoryJob,
    super.gajiMin,
    super.gajiMax,
    super.reference,
  });

  factory LowonganDTO.fromJson(Map<String, dynamic> json) => LowonganDTO(
        id: json["id"] ?? 0,
        courseId: json["course_id"] ?? " ",
        jumlahLowongan: json["jumlah_lowongan"] ?? "0",
        startDateLowongan: json["startdate_lowongan"] == null
            ? DateTime.now()
            : DateTime.parse(json["startdate_lowongan"]),
        endDateLowongan: json["enddate_lowongan"] == null
            ? DateTime.now()
            : DateTime.parse(json["enddate_lowongan"]),
        categoryJob: json["category_job"] ?? "",
        gajiMin: json["gaji_min"] ?? "",
        gajiMax: json["gaji_max"] ?? "",
        reference: json["reference"] ?? "",
      );
}
