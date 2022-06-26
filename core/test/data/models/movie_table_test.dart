import 'package:core/data/models/movie/movie_table.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tMovieTable = MovieTable(
    id: 1,
    title: 'title',
    posterPath: 'posterPath',
    overview: 'overview',
  );

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tMovieTable.toJson();
      // assert
      final expectedJsonMap = {
        "id": 1,
        "title": 'title',
        "posterPath": 'posterPath',
        "overview": 'overview',
      };
      expect(result, expectedJsonMap);
    });
  });
}
