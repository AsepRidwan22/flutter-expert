import 'package:dartz/dartz.dart';
import 'package:proyek_awal/domain/entities/tv/tv_detail.dart';
import 'package:proyek_awal/domain/repositories/tv_repository.dart';
import 'package:proyek_awal/common/failure.dart';

class GetTvDetail {
  final TvRepository repository;

  GetTvDetail(this.repository);

  Future<Either<Failure, TvDetail>> execute(int id) {
    return repository.getTvDetail(id);
  }
}
