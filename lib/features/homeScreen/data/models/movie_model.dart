class MovieModel {
  final String title;
  final String? summary;
  final String? thumbnailUrl;
  final List<String> genres;
  final int? duration;
  final double? rating;

  MovieModel({
    required this.title,
    this.summary,
    this.thumbnailUrl,
    this.genres = const [],
    this.duration,
    this.rating,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    final show = json['show'];
    if (show == null || show is! Map<String, dynamic>) {
      return MovieModel(
        title: 'Unknown Title',
        summary: 'No summary available',
        genres: [],
        duration: null,
        rating: null,
      );
    }

    return MovieModel(
      title: show['name'] ?? 'Unknown Title',
      summary: show['summary']?.replaceAll(RegExp(r'<[^>]*>'), '') ??
          'No summary available',
      thumbnailUrl: show['image']?['medium'], 
      genres: show['genres'] is List ? List<String>.from(show['genres']) : [],
      duration: (show['runtime'] as int?),
      rating: (show['rating']?['average'] as num?)?.toDouble(),
    );
  }
}
