import 'package:core/data/datasources/db/database_helper.dart';
import 'package:core/data/datasources/db/database_helper_tv.dart';

import 'package:core/data/datasources/data_source/movie_local_data_source.dart';
import 'package:core/data/datasources/data_source/tv_local_data_source.dart';

import 'package:core/data/datasources/data_source/movie_remote_data_source.dart';
import 'package:core/data/datasources/data_source/tv_remote_data_source.dart';

import 'package:core/data/repositories/movie_repository_impl.dart';
import 'package:core/data/repositories/tv_repository_impl.dart';

import 'package:core/domain/repositories/movie_repository.dart';
import 'package:core/domain/repositories/tv_repository.dart';

import 'package:movie/domain/usecases/get_movie_detail.dart';
import 'package:tv/domain/usecases/get_tv_detail.dart';

import 'package:movie/domain/usecases/get_movie_recommendations.dart';
import 'package:tv/domain/usecases/get_tv_recommendations.dart';

import 'package:movie/domain/usecases/get_now_playing_movies.dart';
import 'package:tv/domain/usecases/get_now_playing_tv.dart';

import 'package:movie/domain/usecases/get_popular_movies.dart';
import 'package:tv/domain/usecases/get_popular_tv.dart';

import 'package:movie/domain/usecases/get_top_rated_movies.dart';
import 'package:tv/domain/usecases/get_top_rated_tv.dart';

import 'package:watchlist/domain/usecases/movie/get_watchlist_movies.dart';
import 'package:watchlist/domain/usecases/tv/get_watchlist_tv.dart';

import 'package:watchlist/domain/usecases/movie/get_watchlist_status.dart';
import 'package:watchlist/domain/usecases/tv/get_watchlist_status.dart';

import 'package:watchlist/domain/usecases/movie/remove_watchlist.dart';
import 'package:watchlist/domain/usecases/tv/remove_watchlist.dart';

import 'package:watchlist/domain/usecases/movie/save_watchlist.dart';
import 'package:watchlist/domain/usecases/tv/save_watchlist.dart';

import 'package:search/domain/usecases/movie/search_movies.dart';
import 'package:search/domain/usecases/tv/search_tv.dart';
import 'package:search/presentation/bloc/search_bloc.dart';

import 'package:movie/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:movie/presentation/bloc/movie_list_bloc.dart';
import 'package:movie/presentation/bloc/popular_movies_bloc.dart';
import 'package:movie/presentation/bloc/top_rated_movies_bloc.dart';

import 'package:tv/presentation/bloc/popular_tvs_bloc.dart';
import 'package:tv/presentation/bloc/top_rated_tvs_bloc.dart';
import 'package:tv/presentation/bloc/tv_detail/tv_detail_bloc.dart';
import 'package:tv/presentation/bloc/tv_list_bloc.dart';

// import 'package:watchlist/domain/usecases/movie/get_watchlist_movies.dart';
// import 'package:watchlist/domain/usecases/movie/get_watchlist_status.dart';
// import 'package:watchlist/domain/usecases/tv/get_watchlist_status.dart';
// import 'package:watchlist/domain/usecases/tv/get_watchlist_tv.dart';
// import 'package:watchlist/domain/usecases/movie/remove_watchlist.dart';
// import 'package:watchlist/domain/usecases/tv/remove_watchlist.dart';
// import 'package:watchlist/domain/usecases/movie/save_watchlist.dart';
// import 'package:watchlist/domain/usecases/movie/save_watchlist.dart';
import 'package:watchlist/presentation/bloc/watchlist_bloc.dart';

import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() {
  // bloc movie
  locator.registerFactory(
    () => MovieListBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => PopularMoviesBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => MovieDetailBloc(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );

  locator.registerFactory(
    () => SearchMovieBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => WatchlistMoviesBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => TopRatedMoviesBloc(
      locator(),
    ),
  );

  // bloc tv
  locator.registerFactory(
    () => TvDetailBloc(
      getTvDetail: locator(),
      getTvRecommendation: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );

  locator.registerFactory(
    () => WatchlistTvBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => SearchTvBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => TvListBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => PopularTvBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => TopRatedTvsBloc(
      locator(),
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
  locator.registerLazySingleton(() => GetTvRecommendation(locator()));
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
      () => TvLocalDataSourceImpl(tvDatabaseHelperTv: locator()));

  // helper movie
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // helper tv
  locator.registerLazySingleton<DatabaseHelperTv>(() => DatabaseHelperTv());

  // external
  locator.registerLazySingleton(() => http.Client());
}
