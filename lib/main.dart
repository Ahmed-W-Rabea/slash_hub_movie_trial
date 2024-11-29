import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:slashhub_test/features/homeScreen/presentation/bloc/movie_bloc.dart';
import 'package:slashhub_test/features/homeScreen/data/repositories/movie_repository.dart';
import 'package:slashhub_test/features/movie_main/persentation/screens/movie_main.dart';
import 'package:slashhub_test/features/search/presentation/bloc/search_bloc.dart';
import 'package:slashhub_test/features/search/data/repositories/search_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            // Provide the MovieBloc for movie-related functionality
            BlocProvider<MovieBloc>(
              create: (_) => MovieBloc(
                MovieRepositoryImpl(client: http.Client()),
              ),
            ),
            // Provide the SearchBloc for search functionality
            BlocProvider<SearchBloc>(
              create: (_) => SearchBloc(
                SearchRepositoryImpl(client: http.Client()),
              ),
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Movie App',
            home: const MovieMainScreen(), // Ensure your main screen is correct
          ),
        );
      },
    );
  }
}
