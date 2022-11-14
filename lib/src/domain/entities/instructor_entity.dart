import 'package:equatable/equatable.dart';

class InstructorEntity extends Equatable {
  const InstructorEntity({
    required this.id,
    required this.name,
    required this.avatar,
    required this.sub,
  });

  final String id;
  final String name;
  final AvatarEntity avatar;
  final String sub;

  InstructorEntity copyWith({
    String? id,
    String? name,
    AvatarEntity? avatar,
    String? sub,
  }) =>
      InstructorEntity(
        id: id ?? this.id,
        name: name ?? this.name,
        avatar: avatar ?? this.avatar,
        sub: sub ?? this.sub,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "avatar": avatar,
        "sub": sub,
      };

  @override
  List<Object?> get props => [id, name, avatar, sub];
}

class AvatarEntity extends Equatable {
  const AvatarEntity({
    required this.url,
  });

  final String url;

  AvatarEntity copyWith({
    String? url,
  }) =>
      AvatarEntity(
        url: url ?? this.url,
      );

  Map<String, dynamic> toJson() => {
        "url": url,
      };

  @override
  List<Object?> get props => [url];
}
