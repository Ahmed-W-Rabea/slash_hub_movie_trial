import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:slashhub_test/features/homeScreen/data/models/movie_model.dart';

abstract class MovieRepository {
  Future<List<MovieModel>> fetchMovies();
}

class MovieRepositoryImpl implements MovieRepository {
  final http.Client client;

  MovieRepositoryImpl({required this.client});

  @override
  Future<List<MovieModel>> fetchMovies() async {
    final response = await client
        .get(Uri.parse('https://api.tvmaze.com/search/shows?q=all'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => MovieModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }
}
