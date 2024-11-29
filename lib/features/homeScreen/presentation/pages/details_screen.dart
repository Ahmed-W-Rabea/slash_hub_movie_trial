import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:slashhub_test/core/constatnts/constants.dart';
import 'package:slashhub_test/features/homeScreen/data/models/movie_model.dart';
import 'package:slashhub_test/features/homeScreen/presentation/widgets/movie_info.dart';

class MovieDetailPage extends StatelessWidget {
  final MovieModel movie;

  const MovieDetailPage({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackgroundColor,
      appBar: AppBar(
        forceMaterialTransparency: true,
        foregroundColor: Colors.white,
        backgroundColor: Colors.transparent,
        title: Center(
          child: Text(
            "Movie Detail",
            style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Hero(
                    tag: movie.title,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25.r),
                      child: Image.network(
                        movie.thumbnailUrl ?? '',
                        height: 300.h,
                        width: 180.w,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Icon(
                            Icons.error,
                            size: 150.w.h,
                            color: Colors.grey),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MovieInfo(
                        icon: Icons.videocam_rounded,
                        name: "Genre",
                        value: movie.genres.isNotEmpty
                            ? movie.genres.join(', ')
                            : "N/A",
                      ),
                      MovieInfo(
                        icon: Icons.timer,
                        name: "Duration",
                        value: movie.duration != null
                            ? formatTime(Duration(minutes: movie.duration!))
                            : "N/A",
                      ),
                      MovieInfo(
                        icon: Icons.star,
                        name: "Rating",
                        value:
                            movie.rating != null ? "${movie.rating}/10" : "N/A",
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Text(
                movie.title,
                style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w800,
                    color: Colors.white),
              ),
              SizedBox(height: 10.h),
              const Divider(color: Colors.white54),
              Text(
                "summary",
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(height: 10.h),
              Text(
                movie.summary ?? 'No summary available',
                style: TextStyle(
                    fontSize: 14.sp, color: Colors.white70, height: 1.5.h),
              ),
              SizedBox(height: 140.h),
            ],
          ),
        ),
      ),
    );
  }
}
