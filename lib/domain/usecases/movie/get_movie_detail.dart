import 'package:dartz/dartz.dart';
import 'package:proyek_awal/domain/entities/movie/movie_detail.dart';
import 'package:proyek_awal/domain/repositories/movie_repository.dart';
import 'package:proyek_awal/common/failure.dart';

class GetMovieDetail {
  final MovieRepository repository;

  GetMovieDetail(this.repository);

  Future<Either<Failure, MovieDetail>> execute(int id) {
    return repository.getMovieDetail(id);
  }
}
