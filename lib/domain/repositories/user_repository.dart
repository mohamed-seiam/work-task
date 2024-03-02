import 'package:dartz/dartz.dart';
import 'package:work_task/core/errors/failure.dart';

import '../entities/user_entity.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<UserEntity>>> getUsers(
      {int skip = 0,});

  Future<Either<Failure, List<UserEntity>>> searchUsers(
      {required String query});
}
