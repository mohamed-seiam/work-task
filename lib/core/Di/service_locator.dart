import 'package:get_it/get_it.dart';
import 'package:work_task/core/network/api_client.dart';
import 'package:work_task/data/data_source/home_remote_data_source.dart';
import 'package:work_task/data/repositories/home_repository_impl.dart';
import 'package:work_task/domain/usecases/fetch_users_usecase.dart';
import 'package:work_task/domain/usecases/search_user_usecase.dart';
import 'package:work_task/presentation/pages/home_page/cubit/home_cubit.dart';

import '../../domain/repositories/user_repository.dart';

final getItInstance = GetIt.instance;

Future<void> init() async {
  getItInstance.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImplement(
      apiClient: ApiClient(),
    ),
  );
  getItInstance.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImplement(
      homeRemoteDataSource: getItInstance(),
    ),
  );
  getItInstance.registerLazySingleton<FetchUsersUseCase>(
    () => FetchUsersUseCase(homeRepo: getItInstance()),
  );
  getItInstance.registerLazySingleton<SearchUserUseCase>(
    () => SearchUserUseCase(
      homeRepo: getItInstance(),
    ),
  );
  getItInstance.registerSingleton<HomeCubit>(
    HomeCubit(getItInstance(), getItInstance()),
  );
}
