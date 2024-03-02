import 'package:work_task/core/network/api_client.dart';
import 'package:work_task/data/models/users_response_model.dart';
import 'package:work_task/domain/entities/user_entity.dart';

abstract class HomeRemoteDataSource {
  Future<List<UserEntity>> fetchUsers({int skip = 0});

  Future<List<UserEntity>> searchUser({required String query});
}

class HomeRemoteDataSourceImplement implements HomeRemoteDataSource {
  final ApiClient apiClient;

  HomeRemoteDataSourceImplement({required this.apiClient});

  @override
  Future<List<UserEntity>> fetchUsers({int skip = 0}) async {
    final response = await apiClient.getUsers(skip: skip);
    final users = UserResponseModel.fromJson(response).users;
    return users;
  }

  @override
  Future<List<UserEntity>> searchUser({required String query}) async {
    final response = await apiClient.searchUsers(query);
    final users = UserResponseModel.fromJson(response).users;
    print(users);
    return users;
  }
}
