import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:slashhub_test/features/homeScreen/data/models/movie_model.dart';

abstract class SearchRepository {
  Future<List<MovieModel>> searchMovies(String query);
}

class SearchRepositoryImpl implements SearchRepository {
  final http.Client client;

  SearchRepositoryImpl({required this.client});

  @override
  Future<List<MovieModel>> searchMovies(String query) async {
    final response = await client.get(
      Uri.parse('https://api.tvmaze.com/search/shows?q=$query'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => MovieModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch search results');
    }
  }
}
