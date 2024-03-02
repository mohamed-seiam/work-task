import 'package:dartz/dartz.dart';
import 'package:work_task/core/errors/failure.dart';
import 'package:work_task/domain/entities/user_entity.dart';
import 'package:work_task/domain/repositories/user_repository.dart';
import 'package:work_task/domain/usecases/use_case.dart';

class FetchUsersUseCase extends UseCase<List<UserEntity>, int> {
  final HomeRepository homeRepo;

  FetchUsersUseCase({required this.homeRepo});

  @override
  Future<Either<Failure, List<UserEntity>>> call(
      [int param = 0,]) async {
    return await homeRepo.getUsers(skip: param,);
  }
}
