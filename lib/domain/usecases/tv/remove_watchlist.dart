import 'package:dartz/dartz.dart';
import 'package:proyek_awal/common/failure.dart';
import 'package:proyek_awal/domain/entities/tv/tv_detail.dart';
import 'package:proyek_awal/domain/repositories/tv_repository.dart';

class RemoveWatchlistTv {
  final TvRepository repository;

  RemoveWatchlistTv(this.repository);

  Future<Either<Failure, String>> execute(TvDetail tv) {
    return repository.removeWatchlist(tv);
  }
}
