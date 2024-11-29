import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:slashhub_test/core/constatnts/constants.dart';

class MovieCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String summary;

  const MovieCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.summary,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: buttonColor.withOpacity(0.1),
      surfaceTintColor: appBackgroundColor,
      elevation: 5,
      shadowColor: Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
      child: Padding(
        padding: EdgeInsetsDirectional.all(8.w.h),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: Image.network(
                imageUrl,
                height: 200.h,
                width: 150.w,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0.w.h),
              child: Text(
                title,
                style: TextStyle(fontSize: 16.sp, color: Colors.white),
              ),
            ),
            SizedBox(
              width: 150.sp,
              height: 60.sp,
              child: Text(
                summary,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey[700],
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
