import 'package:equatable/equatable.dart';

class Tv extends Equatable {
  Tv({
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
  });

  Tv.watchlist({
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
  });

  int id;
  String? name;
  String? overview;
  String? posterPath;

  @override
  List<Object?> get props => [
        id,
        name,
        overview,
        posterPath,
      ];
}
