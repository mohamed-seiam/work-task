import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../domain/entities/user_entity.dart';

class UserImageWidget extends StatelessWidget {
  const UserImageWidget({
    super.key,
    required this.isAdded,
    this.userEntity,
    this.colors,
  });

  final bool isAdded;
  final UserEntity? userEntity;
  final List<Color>? colors;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: isAdded ?  14.w : 13.w),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: isAdded ? BoxShape.circle : BoxShape.rectangle,
          borderRadius: isAdded ? null : BorderRadius.circular(16),
          border: isAdded
              ? GradientBoxBorder(
                  gradient: LinearGradient(colors: colors ?? [Colors.white,Colors.white]),
                  width: 2)
              : const GradientBoxBorder(
                  gradient: LinearGradient(colors: AppColors.linearColors),
                  width: 2,
                ),
        ),
        width: 56.w,
        height: 56.w,
        child: Container(
          width: 48.w,
          height: 48.w,
          padding: isAdded
              ? EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.w)
              : null,
          decoration: BoxDecoration(
            color: AppColors.lightGrey,
            shape: isAdded ? BoxShape.circle : BoxShape.rectangle,
            borderRadius: isAdded ? null : BorderRadius.circular(14),
          ),
          child: userEntity!=null ?Image.network(
            userEntity?.image ?? '',
            fit: BoxFit.cover,
          ):SvgPicture.asset(AssetsManager.personIcon),
        ),
      ),
    );
  }
}
