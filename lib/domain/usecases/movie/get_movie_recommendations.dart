import 'package:dartz/dartz.dart';
import 'package:proyek_awal/domain/entities/movie/movie.dart';
import 'package:proyek_awal/domain/repositories/movie_repository.dart';
import 'package:proyek_awal/common/failure.dart';

class GetMovieRecommendations {
  final MovieRepository repository;

  GetMovieRecommendations(this.repository);

  Future<Either<Failure, List<Movie>>> execute(id) {
    return repository.getMovieRecommendations(id);
  }
}
