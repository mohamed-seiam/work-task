import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:work_task/core/theme/app_colors.dart';

class UserInformationShimmerWidget extends StatelessWidget {
  const UserInformationShimmerWidget({super.key, required this.isInList});

  final bool isInList;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      color: isInList ? AppColors.lightBlueCardColor : null,
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14.r),
                color: Colors.white,
              ),
              width: 48.0.w,
              height: 48.0.w,
            ),
            Padding(padding: EdgeInsets.symmetric(horizontal: 8.0.w)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 8.0.h,
                    color: Colors.white,
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 2.0.h)),
                  Container(
                    width: double.infinity,
                    height: 8.0.h,
                    color: Colors.white,
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 2.0.h)),
                  Container(
                    width: 40.0.w,
                    height: 8.0.h,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            // Assuming you have an icon button in the real widget
            SizedBox(
              width: 48.0.w,
              height: 48.0.w,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Icon(Icons.add, color: Colors.white)],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
