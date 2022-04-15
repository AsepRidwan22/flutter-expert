import 'package:dartz/dartz.dart';
import 'package:proyek_awal/common/failure.dart';
import 'package:proyek_awal/domain/entities/tv/tv.dart';
import 'package:proyek_awal/domain/repositories/tv_repository.dart';

class GetTopRatedTv {
  final TvRepository repository;

  GetTopRatedTv(this.repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return repository.getTopRatedTv();
  }
}
