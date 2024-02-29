import 'package:work_task/domain/entities/user_entity.dart';

class UserResponseModel {
  final List<Users> users;
  final int total;
  final int skip;
  final int limit;

  UserResponseModel({
    required this.users,
    required this.total,
    required this.skip,
    required this.limit,
  });

  factory UserResponseModel.fromJson(Map<String, dynamic> json) {
    final usersList = json['users'] != null
        ? List<Users>.from(json['users'].map((user) => Users.fromJson(user)))
        : <Users>[];
    return UserResponseModel(
      users: usersList,
      total: json['total'] ?? 0,
      skip: json['skip'] ?? 0,
      limit: json['limit'] ?? 0,
    );
  }
}

class Users extends UserEntity {
  final int id;
  final String username;
  final String image;
  final String email;

  Users(
      {required this.id,
      required this.username,
      required this.image,
      required this.email})
      : super(
          id: id,
          username: username,
          image: image,
          email: email,
        );

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      id: json['id'] ?? 0,
      username: json['username'] ?? '',
      image: json['image'] ?? '',
      email: json['email'] ?? '',
    );
  }
}
