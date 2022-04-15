import 'package:dartz/dartz.dart';
import 'package:proyek_awal/common/failure.dart';
import 'package:proyek_awal/domain/entities/movie/movie.dart';
import 'package:proyek_awal/domain/repositories/movie_repository.dart';

class SearchMovies {
  final MovieRepository repository;

  SearchMovies(this.repository);

  Future<Either<Failure, List<Movie>>> execute(String query) {
    return repository.searchMovies(query);
  }
}
