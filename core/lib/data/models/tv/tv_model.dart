import 'package:core/domain/entities/tv/tv.dart';
import 'package:equatable/equatable.dart';

class Result extends Equatable {
  const Result({
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
  });

  final int id;
  final String name;
  final String overview;
  final String? posterPath;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        name: json["name"],
        overview: json["overview"],
        posterPath: json["poster_path"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "overview": overview,
        "poster_path": posterPath,
      };

  Tv toEntity() {
    return Tv(
      id: id,
      name: name,
      overview: overview,
      posterPath: posterPath,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        posterPath,
      ];
}
