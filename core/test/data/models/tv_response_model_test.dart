import 'dart:convert';

import 'package:core/data/models/tv/tv_model.dart';
import 'package:core/data/models/tv/tv_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  const tTvModel = Result(
    id: 1,
    name: 'name',
    overview: 'overview',
    posterPath: '/path.jpg',
  );

  const tTvResponseModel = TvResponse(tvlist: <Result>[tTvModel]);

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/on_the_air.json'));
      // act
      final result = TvResponse.fromJson(jsonMap);
      // assert
      expect(result, tTvResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTvResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "id": 1,
            "name": 'name',
            "overview": 'overview',
            "poster_path": '/path.jpg',
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
