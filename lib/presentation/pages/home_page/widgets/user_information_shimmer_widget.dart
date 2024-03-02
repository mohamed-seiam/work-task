import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:work_task/core/helper/spacing.dart';
import 'package:work_task/core/theme/app_colors.dart';
import 'package:work_task/presentation/pages/home_page/widgets/user_image_shimmer_widget.dart';

class UserInformationShimmerWidget extends StatelessWidget {
  const UserInformationShimmerWidget({super.key, required this.isInList});

  final bool isInList;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      margin: EdgeInsets.symmetric(vertical: 5.h),
      decoration: BoxDecoration(
        color:  AppColors.lightBlueCardColor,
        borderRadius: BorderRadius.circular(7.r), // Rounded corners
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const UserImageShimmer(),
            horizontalSpacing(4),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    height: 8.0.h,
                    color: Colors.white,
                  ),
                  verticalSpacing(4),
                  Container(
                    width: double.infinity,
                    height: 8.0.h,
                    color: Colors.white,
                  ),
                  verticalSpacing(4),
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
              child: const Center(child: Icon(Icons.add, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
