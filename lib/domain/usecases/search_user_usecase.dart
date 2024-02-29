import 'package:dartz/dartz.dart';
import 'package:work_task/core/errors/failure.dart';
import 'package:work_task/domain/entities/user_entity.dart';
import 'package:work_task/domain/repositories/user_repository.dart';
import 'package:work_task/domain/usecases/use_case.dart';

class SearchUserUseCase extends UseCase<List<UserEntity>, String> {
  final HomeRepository homeRepo;

  SearchUserUseCase({required this.homeRepo});

  @override
  Future<Either<Failure, List<UserEntity>>> call([String? param]) async {
    return await homeRepo.searchUsers(query: param!);
  }
}
