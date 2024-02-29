import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:work_task/core/errors/failure.dart';
import 'package:work_task/data/data_source/home_remote_data_source.dart';
import 'package:work_task/domain/entities/user_entity.dart';
import 'package:work_task/domain/repositories/user_repository.dart';

class HomeRepositoryImplement extends HomeRepository {
  final HomeRemoteDataSource homeRemoteDataSource;

  HomeRepositoryImplement({required this.homeRemoteDataSource});

  @override
  Future<Either<Failure, List<UserEntity>>> getUsers({int skip = 0}) async {
    try {
      final users = await homeRemoteDataSource.fetchUsers(skip: skip);
      return Right(users);
    } catch (error) {
      if (error is DioException) {
        return Left(ServerFailure.fromDioError(error));
      }
      return Left(
        ServerFailure(
          errorMsg: error.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<UserEntity>>> searchUsers(
      {required String query}) async {
    try {
      final users = await homeRemoteDataSource.searchUser(query: query);
      return Right(users);
    } catch (error) {
      if (error is DioException) {
        return Left(ServerFailure.fromDioError(error));
      }
      return Left(
        ServerFailure(
          errorMsg: error.toString(),
        ),
      );
    }
  }
}
