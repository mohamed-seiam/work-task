part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class FetchUsersLoading extends HomeState {}

class FetchUsersSuccess extends HomeState {}

class FetchUsersLoadingFromPagination extends HomeState {}

class FetchUsersFailureFromPagination extends HomeState {
  final String error;

  FetchUsersFailureFromPagination({required this.error});
}

class FetchUsersFailure extends HomeState {
  final String error;

  FetchUsersFailure({required this.error});
}

class ClearSearchingList extends HomeState {}

class SearchUserLoading extends HomeState {}

class SearchUserSuccess extends HomeState {}
class EmptyResultSearchList extends HomeState {}
class SearchUserFailure extends HomeState {
  final String error;

  SearchUserFailure({required this.error});
}

class AddedToGroup extends HomeState {}

class RemovedFromGroup extends HomeState {}
