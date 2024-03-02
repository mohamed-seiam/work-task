import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:work_task/core/network/api_constant.dart';
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
  int skipQuantity = 0;
  bool isDataFinished = false;

  // Future<void> fetchUsers({int skip = 0}) async {
  //   if (skip == 0) {
  //     emit(FetchUsersLoading());
  //   } else {
  //     emit(FetchUsersLoadingFromPagination());
  //   }
  //   final result = await fetchUsersUseCase.call(skip);
  //   result.fold((failure) {
  //     if (skip == 0) {
  //       emit(FetchUsersFailure(error: failure.errorMsg));
  //     } else {
  //       emit(
  //         FetchUsersFailureFromPagination(error: failure.errorMsg),
  //       );
  //     }
  //   }, (users) {
  //     this.users.addAll(users);
  //     emit(FetchUsersSuccess());
  //   });
  // }

  Future<void> fetchUsers() async {
    emit(FetchUsersLoading());
    final result = await fetchUsersUseCase.call(0);
    result.fold((failure) {
      emit(FetchUsersFailure(error: failure.errorMsg));
    }, (users) {
      this.users.addAll(users);
      emit(FetchUsersSuccess());
    });
  }

  Future<void> fetchMoreUsers() async {
    log(isDataFinished.toString());
    if (isDataFinished) return;
    skipQuantity += ApiConstants.paginationLimit;
    emit(FetchUsersLoadingFromPagination());
    final result = await fetchUsersUseCase.call(skipQuantity);
    result.fold((failure) {
      log(failure.errorMsg);
      emit(FetchUsersFailureFromPagination(error: failure.errorMsg));
    }, (users) {
      log(users.toString());
      if (users.isEmpty) {
        isDataFinished = true;
      } else {
        this.users.addAll(users);
      }
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
