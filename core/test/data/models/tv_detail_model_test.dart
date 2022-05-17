import 'package:core/data/models/genre_model.dart';
import 'package:core/data/models/tv/tv_detail_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tTvDetail = TvDetailResponse(
    episodeRunTime: [1, 2, 3, 4],
    genres: [GenreModel(id: 1, name: 'name')],
    id: 1,
    name: 'name',
    numberOfEpisodes: 1,
    numberOfSeasons: 1,
    overview: 'overview',
    posterPath: 'posterPath',
    seasons: [
      Season(
        episodeCount: 1,
        id: 1,
        name: 'name',
        overview: 'overview',
        seasonNumber: 1,
      )
    ],
    voteAverage: 1,
  );

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTvDetail.toJson();
      // assert
      final expectedJsonMap = {
        "episode_run_time": [1, 2, 3, 4],
        "genres": [
          {"id": 1, "name": "name"}
        ],
        "id": 1,
        "name": 'name',
        "number_of_episodes": 1,
        "number_of_seasons": 1,
        "overview": 'overview',
        "poster_path": 'posterPath',
        "seasons": [
          {
            "episode_count": 1,
            "id": 1,
            "name": "name",
            "overview": "overview",
            "season_number": 1,
          }
        ],
        "vote_average": 1,
      };
      expect(result, expectedJsonMap);
    });
  });
}
