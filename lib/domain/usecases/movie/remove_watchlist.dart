import 'package:dartz/dartz.dart';
import 'package:proyek_awal/common/failure.dart';
import 'package:proyek_awal/domain/entities/movie/movie_detail.dart';
import 'package:proyek_awal/domain/repositories/movie_repository.dart';

class RemoveWatchlist {
  final MovieRepository repository;

  RemoveWatchlist(this.repository);

  Future<Either<Failure, String>> execute(MovieDetail movie) {
    return repository.removeWatchlist(movie);
  }
}
