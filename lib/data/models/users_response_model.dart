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
  // @override
  // final int id;
  // @override
  // final String username;
  // @override
  // final String image;
  // @override
  // final String email;

 const Users(
      {required super.id,
      required super.username,
      required super.image,
      required super.email});

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      id: json['id'] ?? 0,
      username: json['username'] ?? '',
      image: json['image'] ?? '',
      email: json['email'] ?? '',
    );
  }
}
