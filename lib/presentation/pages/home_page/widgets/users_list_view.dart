import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_task/presentation/pages/home_page/widgets/user_information_widget.dart';
import 'package:work_task/presentation/pages/home_page/widgets/user_information_shimmer_widget.dart';

import '../cubit/home_cubit.dart';

class UsersListView extends StatefulWidget {
  const UsersListView({
    super.key,
  });

  @override
  State<UsersListView> createState() => _UsersListViewState();
}

class _UsersListViewState extends State<UsersListView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  void _scrollListener() async {
    if (_scrollController.position.atEdge) {
      if (_scrollController.position.pixels != 0) {
        await BlocProvider.of<HomeCubit>(context).fetchMoreUsers();
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
    final cubit = context.read<HomeCubit>();
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) {
        return current is FetchUsersSuccess ||
            current is FetchUsersFailureFromPagination ||
            current is FetchUsersLoadingFromPagination ||
            current is ClearSearchingList ||
            current is SearchUserSuccess ||
            current is EmptyResultSearchList ||
            current is FetchUsersFailure;
      },
      builder: (context, state) {
        final isFetchingMore = state is FetchUsersLoadingFromPagination;
        if (state is FetchUsersSuccess ||
            state is FetchUsersFailureFromPagination ||
            state is FetchUsersLoadingFromPagination ||
            state is ClearSearchingList ||
            state is SearchUserSuccess) {
          return Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              controller: _scrollController,
              itemCount: cubit.displayedUsers.length + (isFetchingMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index >= cubit.displayedUsers.length) {
                  return _buildLoadingIndicator();
                } else {
                  final userEntity = cubit.displayedUsers[index];
                  return UserInformationWidget(
                    userEntity: userEntity,
                  );
                }
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
          return Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: 10,
              itemBuilder: (context, index) {
                return const UserInformationShimmerWidget(isInList: false,);
              },
            ),
          );
        }
      },
    );
  }

  UserInformationShimmerWidget _buildLoadingIndicator() {
     Timer(const Duration(milliseconds: 30), () {
      _scrollController
          .jumpTo(_scrollController.position.maxScrollExtent);
    });
    return const UserInformationShimmerWidget(isInList: true,);
  }
}
