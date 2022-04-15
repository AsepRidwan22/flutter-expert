import 'package:dartz/dartz.dart';
import 'package:proyek_awal/common/failure.dart';
import 'package:proyek_awal/domain/entities/tv/tv.dart';
import 'package:proyek_awal/domain/repositories/tv_repository.dart';

class SearchTv {
  final TvRepository repository;

  SearchTv(this.repository);

  Future<Either<Failure, List<Tv>>> execute(String query) {
    return repository.searchTv(query);
  }
}
