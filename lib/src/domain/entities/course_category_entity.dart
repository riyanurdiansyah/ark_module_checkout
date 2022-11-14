import 'package:equatable/equatable.dart';

class CourseCategoryEntity extends Equatable {
  const CourseCategoryEntity({
    required this.id,
    required this.name,
    required this.slugs,
    required this.image,
  });

  final int id;
  final String name;
  final String slugs;
  final String image;

  @override
  List<Object?> get props => [id, name, slugs, image];

  CourseCategoryEntity copyWith({
    int? id,
    String? name,
    String? slugs,
    String? image,
  }) =>
      CourseCategoryEntity(
        id: id ?? this.id,
        name: name ?? this.name,
        slugs: slugs ?? this.slugs,
        image: image ?? this.image,
      );
}
