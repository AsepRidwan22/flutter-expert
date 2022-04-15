import 'package:dartz/dartz.dart';
import 'package:proyek_awal/domain/entities/movie/movie.dart';
import 'package:proyek_awal/domain/repositories/movie_repository.dart';
import 'package:proyek_awal/common/failure.dart';

class GetNowPlayingMovies {
  final MovieRepository repository;

  GetNowPlayingMovies(this.repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return repository.getNowPlayingMovies();
  }
}
