import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchMoviesEvent extends SearchEvent {
  final String query;

  const SearchMoviesEvent({required this.query});

  @override
  List<Object> get props => [query];
}
