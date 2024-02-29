import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:work_task/presentation/pages/home_page/cubit/home_cubit.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/utils/assets_manager.dart';

class TextFormSearchWidget extends StatelessWidget {
  const TextFormSearchWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 14.w),
      decoration: BoxDecoration(
        color: AppColors.searchCardColor,
        // Background color of the TextField
        borderRadius: BorderRadius.circular(7), // Rounded corners
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search',
          hintStyle: AppTextStyles.style12,
          icon: SvgPicture.asset(AssetsManager.searchIcon),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            vertical: 13.h,
          ), // Adjust padding as needed
        ),
        onChanged: (value) {
          if (value.isEmpty) {
            context.read<HomeCubit>().clearSearchedList();
          } else {
            context.read<HomeCubit>().searchUser(query: value);
          }
        },
      ),
    );
  }
}
