import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:work_task/core/helper/spacing.dart';
import 'package:work_task/core/theme/app_colors.dart';
import 'package:work_task/presentation/pages/home_page/cubit/home_cubit.dart';
import 'package:work_task/presentation/pages/home_page/widgets/group_listview_widget.dart';
import 'package:work_task/presentation/pages/home_page/widgets/text_form_search_widget.dart';
import 'package:work_task/presentation/pages/home_page/widgets/users_list_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
          ).copyWith(top: 30.h),
          child: RefreshIndicator(
            onRefresh: () async {
              await context.read<HomeCubit>().fetchUsers();
            },
            child: Column(
              children: [
               const GroupListViewWidget(),
                verticalSpacing(16),
                Divider(
                  color: AppColors.lightGrey,
                  thickness: 1.h,
                ),
                verticalSpacing(16),
                const TextFormSearchWidget(),
                verticalSpacing(16),
                const UsersListView(),
                BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    if (state is FetchUsersLoadingFromPagination) {
                      return Padding(
                        padding:  EdgeInsets.symmetric(vertical: 8.0.h),
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

