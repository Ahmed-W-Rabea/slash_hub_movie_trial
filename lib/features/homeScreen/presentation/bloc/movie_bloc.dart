import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slashhub_test/features/homeScreen/data/repositories/movie_repository.dart';
import 'package:slashhub_test/features/homeScreen/data/models/movie_model.dart';
import 'package:slashhub_test/features/homeScreen/presentation/bloc/movie_event.dart';
import 'package:slashhub_test/features/homeScreen/presentation/bloc/movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieRepository movieRepository;

  MovieBloc(this.movieRepository) : super(MovieInitial()) {
    on<FetchMoviesEvent>(_onFetchMovies);
  }

  Future<void> _onFetchMovies(
      FetchMoviesEvent event, Emitter<MovieState> emit) async {
    emit(MovieLoading());
    try {
      final List<MovieModel> movies = await movieRepository.fetchMovies();
      emit(MovieLoaded(movies));
    } catch (error) {
      emit(MovieError(error.toString()));
    }
  }
}
