import 'package:dartz/dartz.dart';
import 'package:proyek_awal/domain/entities/tv/tv.dart';
import 'package:proyek_awal/domain/repositories/tv_repository.dart';
import 'package:proyek_awal/common/failure.dart';

class GetTvRecommendations {
  final TvRepository repository;

  GetTvRecommendations(this.repository);

  Future<Either<Failure, List<Tv>>> execute(id) {
    return repository.getTvRecommendation(id);
  }
}
