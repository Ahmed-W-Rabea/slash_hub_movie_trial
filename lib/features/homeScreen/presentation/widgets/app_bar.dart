import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:slashhub_test/core/constatnts/constants.dart';

AppBar headerParts() {
  return AppBar(
    backgroundColor: appBackgroundColor,
    title: Padding(
      padding:  EdgeInsets.symmetric(horizontal: 10.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "Welcome Ahmed",
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1,
                          color: Colors.white54),
                    ),
                    TextSpan(
                      text: "👋",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "Let's relax and watch a movie!",
                style: TextStyle(
                    height: 0.6,
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1),
              )
            ],
          ),
          Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                image: const DecorationImage(
                    image: AssetImage("assets/images/boy.png"),
                    fit: BoxFit.cover)),
          )
        ],
      ),
    ),
  );
}
