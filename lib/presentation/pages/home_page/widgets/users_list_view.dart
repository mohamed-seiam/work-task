import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_task/presentation/pages/home_page/widgets/user_information_widget.dart';

import '../../../../domain/entities/user_entity.dart';
import '../cubit/home_cubit.dart';

class UsersListView extends StatefulWidget {
  const UsersListView({
    super.key,
  });

  @override
  State<UsersListView> createState() => _UsersListViewState();
}

class _UsersListViewState extends State<UsersListView> {
  List<UserEntity> users = [];
  List<UserEntity> tester = [];
  final ScrollController _scrollController = ScrollController();
  int nextSkip = 1;
  bool isLoading = false;

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  void _scrollListener() async {
    var currentPosition = _scrollController.position.pixels;
    var maxScrollLenght = _scrollController.position.maxScrollExtent;
    if (currentPosition >= 0.7 * maxScrollLenght) {
      if (!isLoading) {
        isLoading = false;
        await BlocProvider.of<HomeCubit>(context)
            .fetchUsers(skip: (nextSkip++) * 10);
        isLoading = true;
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      buildWhen: (previous, current) {
        return current is FetchUsersSuccess ||
            current is FetchUsersFailureFromPagination ||
            current is FetchUsersLoadingFromPagination ||
            current is ClearSearchingList ||
            current is SearchUserSuccess ||
            current is EmptyResultSearchList;
      },
      listener: (context, state) {
        // final cubit = context.read<HomeCubit>();
        // if (state is FetchUsersSuccess) {
        //   users.addAll(cubit.users);
        //   tester = users;
        // }
        // if (state is SearchUserSuccess) {
        //   users = cubit.searchedUser;
        // }
        // if (state is ClearSearchingList) {
        //   users = tester;
        // }
      },
      builder: (context, state) {
        final cubit = context.read<HomeCubit>();
        if (state is FetchUsersSuccess ||
            state is FetchUsersFailureFromPagination ||
            state is FetchUsersLoadingFromPagination ||
            state is ClearSearchingList ||
            state is SearchUserSuccess) {
          return Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              controller: _scrollController,
              itemCount: cubit.displayedUsers.length,
              itemBuilder: (context, index) {
                final userEntity = cubit.displayedUsers[index];
                return UserInformationWidget(
                  userEntity: userEntity,
                );
              },
            ),
          );
        } else if (state is FetchUsersFailure) {
          return Center(
            child: Text(state.error),
          );
        } else if (state is EmptyResultSearchList) {
          return const Center(
            child: Text('Not found User with this name'),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
