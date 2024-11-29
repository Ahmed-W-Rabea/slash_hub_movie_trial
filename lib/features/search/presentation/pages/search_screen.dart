import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:slashhub_test/core/constatnts/constants.dart';
import 'package:slashhub_test/features/homeScreen/presentation/pages/details_screen.dart';
import 'package:slashhub_test/features/homeScreen/presentation/widgets/movie_card.dart';
import 'package:slashhub_test/features/search/presentation/bloc/search_bloc.dart';
import 'package:slashhub_test/features/search/presentation/bloc/search_event.dart';
import 'package:slashhub_test/features/search/presentation/bloc/search_state.dart';
import 'package:slashhub_test/features/search/presentation/widgets/search_field.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // Add a controller to manage the search field's input
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackgroundColor,
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Search Movies',
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: appBackgroundColor,
      ),
      body: Column(
        children: [
          // Search field to trigger search action
          SearchField(
            controller: _controller,
            onSearch: (query) {
              if (query.isNotEmpty) {
                // Dispatch the search event with the query
                context.read<SearchBloc>().add(SearchMoviesEvent(query: query));
              }
            },
          ),
          Expanded(
            child: BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                if (state is SearchLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is SearchLoaded) {
                  // Handle the loaded state
                  return state.movies.isEmpty
                      ? const Center(
                          child: Text(
                            'No movies found.',
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      : SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          physics: const BouncingScrollPhysics(),
                          child: Padding(
                            padding:  EdgeInsets.symmetric(horizontal: 12.w),
                            child: Column(
                              children: state.movies.map((movie) {
                                return GestureDetector(
                                  onTap: () {
                                    // Navigate to movie detail page
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MovieDetailPage(
                                          movie: movie,
                                        ),
                                      ),
                                    );
                                  },
                                  child: // Assuming movie is now a map (like 'show' in HomeScreen)
                                      MovieCard(
                                    imageUrl: movie.thumbnailUrl ??
                                        'https://th.bing.com/th/id/OIP.RVix6boCCPv3glrGyX3V2gHaFj?rs=1&pid=ImgDetMain',
                                    title: movie.title,
                                    summary: movie.summary ?? 'No Summary',
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        );
                } else if (state is SearchError) {
                  // Handle error state
                  return Center(
                    child: Text(
                      state.message,
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                } else {
                  // Default state when nothing is loaded or searching
                  return const Center(
                    child: Text(
                      'Start searching for movies.',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
