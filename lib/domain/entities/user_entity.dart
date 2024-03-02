import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final int id;
  final String username;
  final String image;
  final String email;

  const UserEntity(
      {required this.id,
      required this.username,
      required this.image,
      required this.email});

  @override
  List<Object?> get props => [id, username, image, email];
}
