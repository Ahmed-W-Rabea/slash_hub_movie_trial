import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slashhub_test/features/search/data/repositories/search_repository.dart';
import 'package:slashhub_test/features/search/presentation/bloc/search_event.dart';
import 'package:slashhub_test/features/search/presentation/bloc/search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchRepository searchRepository;

  SearchBloc(this.searchRepository) : super(SearchInitial()) {
    on<SearchMoviesEvent>(_onSearchMovies);
  }

  // Handle SearchMoviesEvent
  Future<void> _onSearchMovies(
      SearchMoviesEvent event, Emitter<SearchState> emit) async {
    emit(SearchLoading());

    try {
      final movies = await searchRepository.searchMovies(event.query);

      // Emit SearchLoaded state if movies are found
      if (movies.isEmpty) {
        emit(SearchError("No movies found for '${event.query}'."));
      } else {
        emit(SearchLoaded(movies));
      }
    } catch (error) {
      // Emit SearchError state if fetching fails
      emit(SearchError("Failed to load search results. Please try again."));
      print("Search Error: $error");
    }
  }
}
