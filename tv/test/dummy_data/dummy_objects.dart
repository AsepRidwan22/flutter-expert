import 'package:core/data/models/tv/tv_detail_model.dart';
import 'package:core/data/models/tv/tv_table.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:core/domain/entities/tv/tv.dart';
import 'package:core/domain/entities/tv/tv_detail.dart';

final testTv = Tv(
  id: 52814,
  name: 'Halo',
  overview:
      'Depicting an epic 26th-century conflict between humanity and an alien threat known as the Covenant, the series weaves deeply drawn personal stories with action, adventure and a richly imagined vision of the future.',
  posterPath: '/nJUHX3XL1jMkk8honUZnUmudFb9.jpg',
);

final testTvList = [testTv];

const testTvDetail = TvDetail(
  episodeRunTime: [1],
  genres: [Genre(id: 1, name: 'name')],
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

final testWatchlistTv = Tv.watchlist(
  id: 1,
  name: 'name',
  overview: 'overview',
  posterPath: 'posterPath',
);

const testTvTable = TvTable(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};

final testTvMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'name': 'name',
};
