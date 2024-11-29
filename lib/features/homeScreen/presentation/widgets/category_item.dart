import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:slashhub_test/features/homeScreen/data/models/category_model.dart';

categoryItems() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: List.generate(
        categories.length,
        (index) => Column(
              children: [
                Container(
                  padding: EdgeInsets.all(15.w.h),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child: Image.asset(
                    categories[index].emoji,
                    fit: BoxFit.cover,
                    height: 30.h,
                    width: 30.w,
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  categories[index].name,
                  style: TextStyle(fontSize: 12.sp, color: Colors.white),
                )
              ],
            )),
  );
}
