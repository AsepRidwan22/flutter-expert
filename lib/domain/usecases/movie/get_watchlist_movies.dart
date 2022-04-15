import 'package:dartz/dartz.dart';
import 'package:proyek_awal/domain/entities/movie/movie.dart';
import 'package:proyek_awal/domain/repositories/movie_repository.dart';
import 'package:proyek_awal/common/failure.dart';

class GetWatchlistMovies {
  final MovieRepository _repository;

  GetWatchlistMovies(this._repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return _repository.getWatchlistMovies();
  }
}
