import 'package:equatable/equatable.dart';

class LowonganEntity extends Equatable {
  const LowonganEntity({
    this.id,
    this.courseId,
    this.jumlahLowongan,
    this.startDateLowongan,
    this.endDateLowongan,
    this.categoryJob,
    this.gajiMin,
    this.gajiMax,
    this.reference,
  });

  final int? id;
  final String? courseId;
  final String? jumlahLowongan;
  final DateTime? startDateLowongan;
  final DateTime? endDateLowongan;
  final String? categoryJob;
  final String? gajiMin;
  final String? gajiMax;
  final String? reference;

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        courseId,
        jumlahLowongan,
        startDateLowongan,
        endDateLowongan,
        categoryJob,
        gajiMin,
        gajiMax,
        reference
      ];
}
