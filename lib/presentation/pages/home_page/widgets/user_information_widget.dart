import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:work_task/presentation/pages/home_page/cubit/home_cubit.dart';
import 'package:work_task/presentation/pages/home_page/widgets/user_image_widget.dart';

import '../../../../core/helper/spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../domain/entities/user_entity.dart';

class UserInformationWidget extends StatelessWidget {
  const UserInformationWidget({
    super.key,
    required this.userEntity,
  });

  final UserEntity userEntity;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) {
        return current is AddedToGroup || current is RemovedFromGroup;
      },
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            color: cubit.groupUsers.contains(userEntity)
                ? AppColors.lightPurpleCardColor
                : AppColors.lightBlueCardColor,
            // Light blue background color
            borderRadius: BorderRadius.circular(7.r), // Rounded corners
          ),
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          margin: EdgeInsets.symmetric(vertical: 5.h),
          // Optional: to provide spacing between items
          child: Row(
            children: [
              UserImageWidget(isAdded: false, userEntity: userEntity),
              horizontalSpacing(4),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userEntity.username,
                      style: AppTextStyles.style13,
                    ),
                    verticalSpacing(4),
                    Text(
                      userEntity.email,
                      style: AppTextStyles.style10,
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  if (cubit.groupUsers.contains(userEntity)) {
                    showDeleteConfirmationDialog(context, cubit, userEntity.id);
                  } else {
                    cubit.addToGroup(userEntity: userEntity);
                  }
                },
                child: cubit.groupUsers.contains(userEntity)
                    ? SvgPicture.asset(AssetsManager.deleteIcon)
                    : SvgPicture.asset(AssetsManager.addIcon),
              ),
            ],
          ),
        );
      },
    );
  }

  void showDeleteConfirmationDialog(
      BuildContext context, HomeCubit cubit, int userId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Theme(
          data: Theme.of(context).copyWith(
            dialogBackgroundColor: Colors.white, // Set AlertDialog background color to white
          ),
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20.0.r),
              ),
            ),
            title: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 56.w,
                  height: 56.h,
                  padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 13.h),
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.lightBlueCardColor),
                  child: SvgPicture.asset(AssetsManager.deleteIcon),
                ),
                SizedBox(
                  height: 4.h,
                ),
                Text(
                  'Delete',
                  style: AppTextStyles.style16,
                ),
              ],
            ),
            // Delete icon
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 37.w).copyWith(
                    top: 7.h,
                    bottom: 14.h,
                  ),
                  child: Text(
                    'Are you sure you want to delete the profile from home page?',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.style10,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 26.h,
                        width: 82.w,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: AppColors.linearColors,
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius:
                              BorderRadius.circular(8), // Little border radius
                        ),
                        child: TextButton(
                          child: Text(
                            'OK',
                            textAlign: TextAlign.center,
                            style: AppTextStyles.style13.copyWith(
                              fontSize: 11.sp,
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            cubit.removeFromGroup(
                                id: userEntity.id); // Perform delete action
                            Navigator.of(context).pop(); // Close the dialog
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 18.w,
                    ),
                    Expanded(
                      child: Container(
                        height: 26.h,
                        width: 74.w,
                        decoration: BoxDecoration(
                          color: AppColors.lightGrey,
                          borderRadius:
                              BorderRadius.circular(8.r), // Little border radius
                        ),
                        child: TextButton(
                          child: Text(
                            'Skip',
                            textAlign: TextAlign.center,
                            style: AppTextStyles.style10.copyWith(
                              fontWeight: FontWeight.w500,
                              color: AppColors.darkGrey,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
