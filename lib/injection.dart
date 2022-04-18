import 'package:proyek_awal/data/datasources/db/database_helper.dart';
import 'package:proyek_awal/data/datasources/db/database_helper_tv.dart';

import 'package:proyek_awal/data/datasources/data_source/movie_local_data_source.dart';
import 'package:proyek_awal/data/datasources/data_source/tv_local_data_source.dart';

import 'package:proyek_awal/data/datasources/data_source/movie_remote_data_source.dart';
import 'package:proyek_awal/data/datasources/data_source/tv_remote_data_source.dart';

import 'package:proyek_awal/data/repositories/movie_repository_impl.dart';
import 'package:proyek_awal/data/repositories/tv_repository_impl.dart';

import 'package:proyek_awal/domain/repositories/movie_repository.dart';
import 'package:proyek_awal/domain/repositories/tv_repository.dart';

import 'package:proyek_awal/domain/usecases/movie/get_movie_detail.dart';
import 'package:proyek_awal/domain/usecases/tv/get_tv_detail.dart';

import 'package:proyek_awal/domain/usecases/movie/get_movie_recommendations.dart';
import 'package:proyek_awal/domain/usecases/tv/get_tv_recommendations.dart';

import 'package:proyek_awal/domain/usecases/movie/get_now_playing_movies.dart';
import 'package:proyek_awal/domain/usecases/tv/get_now_playing_tv.dart';

import 'package:proyek_awal/domain/usecases/movie/get_popular_movies.dart';
import 'package:proyek_awal/domain/usecases/tv/get_popular_tv.dart';

import 'package:proyek_awal/domain/usecases/movie/get_top_rated_movies.dart';
import 'package:proyek_awal/domain/usecases/tv/get_top_rated_tv.dart';

import 'package:proyek_awal/domain/usecases/movie/get_watchlist_movies.dart';
import 'package:proyek_awal/domain/usecases/tv/get_watchlist_tv.dart';

import 'package:proyek_awal/domain/usecases/movie/get_watchlist_status.dart';
import 'package:proyek_awal/domain/usecases/tv/get_watchlist_status.dart';

import 'package:proyek_awal/domain/usecases/movie/remove_watchlist.dart';
import 'package:proyek_awal/domain/usecases/tv/remove_watchlist.dart';

import 'package:proyek_awal/domain/usecases/movie/save_watchlist.dart';
import 'package:proyek_awal/domain/usecases/tv/save_watchlist.dart';

import 'package:proyek_awal/domain/usecases/movie/search_movies.dart';
import 'package:proyek_awal/domain/usecases/tv/search_tv.dart';

import 'package:proyek_awal/presentation/provider/movie/movie_detail_notifier.dart';
import 'package:proyek_awal/presentation/provider/tv/tv_detail_notifier.dart';

import 'package:proyek_awal/presentation/provider/movie/movie_list_notifier.dart';
import 'package:proyek_awal/presentation/provider/tv/tv_list_notifier.dart';

import 'package:proyek_awal/presentation/provider/movie/movie_search_notifier.dart';
import 'package:proyek_awal/presentation/provider/tv/tv_search_notifier.dart';

import 'package:proyek_awal/presentation/provider/movie/popular_movies_notifier.dart';
import 'package:proyek_awal/presentation/provider/tv/popular_tv_notifier.dart';

import 'package:proyek_awal/presentation/provider/movie/top_rated_movies_notifier.dart';
import 'package:proyek_awal/presentation/provider/tv/top_rated_tv_notifier.dart';

import 'package:proyek_awal/presentation/provider/movie/watchlist_movie_notifier.dart';
import 'package:proyek_awal/presentation/provider/tv/watchlist_tv_notifier.dart';

import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() {
  // provider movie
  locator.registerFactory(
    () => MovieListNotifier(
      getNowPlayingMovies: locator(),
      getPopularMovies: locator(),
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieDetailNotifier(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieSearchNotifier(
      searchMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularMoviesNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMoviesNotifier(
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistMovieNotifier(
      getWatchlistMovies: locator(),
    ),
  );

  // provider tv
  locator.registerFactory(
    () => TvListNotifier(
      getNowPlayingTv: locator(),
      getPopularTv: locator(),
      getTopRatedTv: locator(),
    ),
  );
  locator.registerFactory(
    () => TvDetailNotifier(
      getTvDetail: locator(),
      getTvRecommendations: locator(),
      getWatchListStatusTv: locator(),
      saveWatchlistTv: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => TvSearchNotifier(
      searchTv: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularTvNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedTvNotifier(
      getTopRatedTv: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistTvNotifier(
      getWatchlistTv: locator(),
    ),
  );

  // use case movie
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  // use case tv
  locator.registerLazySingleton(() => GetNowPlayingTv(locator()));
  locator.registerLazySingleton(() => GetPopularTv(locator()));
  locator.registerLazySingleton(() => GetTopRatedTv(locator()));
  locator.registerLazySingleton(() => GetTvDetail(locator()));
  locator.registerLazySingleton(() => GetTvRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTv(locator()));
  locator.registerLazySingleton(() => GetWatchListStatusTv(locator()));
  locator.registerLazySingleton(() => SaveWatchlistTv(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTv(locator()));
  locator.registerLazySingleton(() => GetWatchlistTv(locator()));

  // repository movie
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // repository tv
  locator.registerLazySingleton<TvRepository>(
    () => TvRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources movie
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  // data sources tv
  locator.registerLazySingleton<TvRemoteDataSource>(
      () => TvRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TvLocalDataSource>(
      () => TvLocalDataSourceImpl(TvDatabaseHelperTv: locator()));

  // helper movie
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // helper tv
  locator.registerLazySingleton<DatabaseHelperTv>(() => DatabaseHelperTv());

  // external
  locator.registerLazySingleton(() => http.Client());
}