import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:work_task/domain/usecases/fetch_users_usecase.dart';
import 'package:work_task/domain/usecases/search_user_usecase.dart';
import '../../../../domain/entities/user_entity.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.fetchUsersUseCase, this.searchUserUseCase)
      : super(HomeInitial());
  final FetchUsersUseCase fetchUsersUseCase;
  final SearchUserUseCase searchUserUseCase;
  List<UserEntity> users = [];
  List<UserEntity> searchedUser = [];
  List<UserEntity> groupUsers = [];

  Future<void> fetchUsers({int skip = 0}) async {
    if (skip == 0) {
      emit(FetchUsersLoading());
    } else {
      emit(FetchUsersLoadingFromPagination());
    }
    final result = await fetchUsersUseCase.call(skip);
    result.fold((failure) {
      if (skip == 0) {
        emit(FetchUsersFailure(error: failure.errorMsg));
      } else {
        emit(
          FetchUsersFailureFromPagination(error: failure.errorMsg),
        );
      }
    }, (users) {
      this.users.addAll(users);
      emit(FetchUsersSuccess());
    });
  }

  List<UserEntity> get displayedUsers =>
      searchedUser.isEmpty ? users : searchedUser;

  Future<void> searchUser({required String query}) async {
    emit(SearchUserLoading());
    final result = await searchUserUseCase.call(query);
    result.fold((failure) {
      emit(
        SearchUserFailure(error: failure.errorMsg),
      );
    }, (searchingResult) {
      searchedUser = searchingResult;
      if (searchingResult.isEmpty) {
        emit(EmptyResultSearchList());
      } else {
        emit(SearchUserSuccess());
      }
    });
  }

  void clearSearchedList() {
    searchedUser.clear();
    emit(ClearSearchingList());
  }

  void addToGroup({required UserEntity userEntity}) {
    groupUsers.add(userEntity);
    emit(AddedToGroup());
  }

  void removeFromGroup({required int id}) {
    groupUsers.removeWhere((element) => element.id == id);
    emit(RemovedFromGroup());
  }
}
