import 'package:core/data/models/tv/tv_model.dart';
import 'package:core/domain/entities/tv/tv.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tTvModel = Result(
    id: 1,
    name: 'name',
    overview: 'overview',
    posterPath: 'posterPath',
  );

  final tTv = Tv(
    id: 1,
    name: 'name',
    overview: 'overview',
    posterPath: 'posterPath',
  );

  test('should be a subclass of Tv entity', () async {
    final result = tTvModel.toEntity();
    expect(result, tTv);
  });
}
