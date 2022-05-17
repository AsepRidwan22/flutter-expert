import 'package:core/data/models/tv/tv_table.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tTvTable = TvTable(
    id: 1,
    name: 'name',
    posterPath: 'posterPath',
    overview: 'overview',
  );

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTvTable.toJson();
      // assert
      final expectedJsonMap = {
        "id": 1,
        "name": 'name',
        "posterPath": 'posterPath',
        "overview": 'overview',
      };
      expect(result, expectedJsonMap);
    });
  });
}
