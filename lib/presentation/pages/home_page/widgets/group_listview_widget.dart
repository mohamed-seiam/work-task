import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:work_task/core/theme/app_colors.dart';
import 'package:work_task/presentation/pages/home_page/cubit/home_cubit.dart';
import 'package:work_task/presentation/pages/home_page/widgets/user_image_widget.dart';

class GroupListViewWidget extends StatelessWidget {
  const GroupListViewWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) {
        return current is AddedToGroup || current is RemovedFromGroup;
      },
      builder: (context, state) {
        return cubit.groupUsers.isEmpty
            ? SizedBox(
                height: 56.h,
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.horizontal,
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return const UserImageWidget(isAdded: true);
                  },
                ),
              )
            : SizedBox(
                height: 56.h,
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.horizontal,
                  itemCount: cubit.groupUsers.length,
                  itemBuilder: (context, index) {
                    final userEntity = cubit.groupUsers[index];
                    return UserImageWidget(
                      isAdded: true,
                      userEntity: userEntity,
                      colors: AppColors.linearColors,
                    );
                  },
                ));
      },
    );
  }
}
