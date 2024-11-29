import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:slashhub_test/core/constatnts/constants.dart';
import 'package:slashhub_test/features/homeScreen/presentation/bloc/movie_bloc.dart';
import 'package:slashhub_test/features/homeScreen/presentation/bloc/movie_event.dart';
import 'package:slashhub_test/features/homeScreen/presentation/bloc/movie_state.dart';
import 'package:slashhub_test/features/homeScreen/presentation/pages/details_screen.dart';
import 'package:slashhub_test/features/homeScreen/presentation/widgets/app_bar.dart';
import 'package:slashhub_test/features/homeScreen/presentation/widgets/category_item.dart';
import 'package:slashhub_test/features/homeScreen/presentation/widgets/movie_card.dart';
import 'package:slashhub_test/features/movie_main/persentation/screens/movie_main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<MovieBloc>().add(FetchMoviesEvent());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: headerParts(),
      backgroundColor: appBackgroundColor,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Divider(color: Colors.grey.withOpacity(0.2)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: GestureDetector(
                onTap: () {
                  // Navigate by updating the current index in the parent state.
                  final parentState =
                      context.findAncestorStateOfType<CinemaMainScreenState>();
                  parentState?.updateIndex(1); 
                },
                child: Container(
                  height: 50.h,
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1), // Transparent effect
                    borderRadius: BorderRadius.circular(27.r),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.search, color: Colors.white),
                      SizedBox(width: 10.w),
                      Text(
                        "Search for movies...",
                        style:
                            TextStyle(color: Colors.white54, fontSize: 14.sp),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Categories
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: categoryItems(),
            ),
            Divider(color: Colors.grey.withOpacity(0.2)),
            // Recommendations
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Recommendations",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "See More",
                      style: TextStyle(fontSize: 16.sp, color: buttonColor),
                    ),
                  ),
                ],
              ),
            ),
            BlocBuilder<MovieBloc, MovieState>(
              builder: (context, state) {
                if (state is MovieLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is MovieLoaded) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: Row(
                        children: state.movies.take(8).map((movie) {
                          // Assuming movie is already an instance of MovieModel
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      MovieDetailPage(movie: movie),
                                ),
                              );
                            },
                            child: MovieCard(
                              imageUrl: movie.thumbnailUrl ??
                                  "https://th.bing.com/th/id/OIP.RVix6boCCPv3glrGyX3V2gHaFj?rs=1&pid=ImgDetMain",
                              title: movie.title ?? 'No Title',
                              summary: movie.summary ?? 'No Summary',
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  );
                } else if (state is MovieError) {
                  return Center(
                    child: Text(
                      state.message,
                      style: TextStyle(fontSize: 16.sp, color: Colors.red),
                    ),
                  );
                } else {
                  return const Center(child: Text("No data available"));
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
