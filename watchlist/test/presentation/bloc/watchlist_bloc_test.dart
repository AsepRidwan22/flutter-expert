import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/movie/movie.dart';
import 'package:core/domain/entities/tv/tv.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:watchlist/domain/usecases/movie/get_watchlist_movies.dart';
import 'package:watchlist/domain/usecases/tv/get_watchlist_tv.dart';
import 'package:watchlist/presentation/bloc/watchlist_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistMovies, GetWatchlistTv])
void main() {
  late WatchlistMoviesBloc watchlistMoviesBloc;
  late WatchlistTvBloc watchlistTvBloc;
  late MockGetWatchlistMovies mockGetWatchlistMovies;
  late MockGetWatchlistTv mockGetWatchlistTv;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    mockGetWatchlistTv = MockGetWatchlistTv();
    watchlistMoviesBloc = WatchlistMoviesBloc(mockGetWatchlistMovies);
    watchlistTvBloc = WatchlistTvBloc(mockGetWatchlistTv);
  });

  final tMovieList = <Movie>[testMovie];

  group('Watchlist Movies', () {
    test('initialState should be Empty', () {
      expect(watchlistMoviesBloc.state, WatchlistEmpty());
    });

    blocTest<WatchlistMoviesBloc, WatchlistState>(
        'should emit [WatchlistLoading, WatchlistLoaded] when data is gotten successfully',
        build: () {
          when(mockGetWatchlistMovies.execute())
              .thenAnswer((_) async => Right(tMovieList));
          return watchlistMoviesBloc;
        },
        act: (bloc) => bloc.add(WatchlistEvent()),
        expect: () => [
              WatchlistLoading(),
              WatchlistLoaded(tMovieList),
            ],
        verify: (bloc) => verify(mockGetWatchlistMovies.execute()));

    blocTest<WatchlistMoviesBloc, WatchlistState>(
        'should emit [WatchlistLoading, WatchlistLoaded[]] when data is gotten successfully',
        build: () {
          when(mockGetWatchlistMovies.execute())
              .thenAnswer((_) async => const Right(<Movie>[]));
          return watchlistMoviesBloc;
        },
        act: (bloc) => bloc.add(WatchlistEvent()),
        expect: () => [
              WatchlistLoading(),
              const WatchlistLoaded(<Movie>[]),
            ],
        verify: (bloc) => verify(mockGetWatchlistMovies.execute()));

    blocTest<WatchlistMoviesBloc, WatchlistState>(
        'should emit [WatchlistLoading, WatchlistLoaded] when data is unsuccessful',
        build: () {
          when(mockGetWatchlistMovies.execute()).thenAnswer(
              (_) async => const Left(ServerFailure('Server Failure')));
          return watchlistMoviesBloc;
        },
        act: (bloc) => bloc.add(WatchlistEvent()),
        expect: () => [
              WatchlistLoading(),
              const WatchlistError('Server Failure'),
            ],
        verify: (bloc) => verify(mockGetWatchlistMovies.execute()));
  });

  final tTvList = <Tv>[testTv];

  group('Watchlist Tvs', () {
    test('initialState should be Empty', () {
      expect(watchlistTvBloc.state, WatchlistEmpty());
    });

    blocTest<WatchlistTvBloc, WatchlistState>(
        'should emit [WatchlistLoading, WatchlistLoaded] when data is gotten successfully',
        build: () {
          when(mockGetWatchlistTv.execute())
              .thenAnswer((_) async => Right(tTvList));
          return watchlistTvBloc;
        },
        act: (bloc) => bloc.add(WatchlistEvent()),
        expect: () => [
              WatchlistLoading(),
              WatchlistLoaded(tTvList),
            ],
        verify: (bloc) => verify(mockGetWatchlistTv.execute()));

    blocTest<WatchlistTvBloc, WatchlistState>(
        'should emit [WatchlistLoading, WatchlistLoaded[]] when data is gotten successfully',
        build: () {
          when(mockGetWatchlistTv.execute())
              .thenAnswer((_) async => const Right(<Tv>[]));
          return watchlistTvBloc;
        },
        act: (bloc) => bloc.add(WatchlistEvent()),
        expect: () => [
              WatchlistLoading(),
              const WatchlistLoaded(<Tv>[]),
            ],
        verify: (bloc) => verify(mockGetWatchlistTv.execute()));

    blocTest<WatchlistTvBloc, WatchlistState>(
        'should emit [WatchlistLoading, WatchlistLoaded] when data is unsuccessful',
        build: () {
          when(mockGetWatchlistTv.execute()).thenAnswer(
              (_) async => const Left(ServerFailure('Server Failure')));
          return watchlistTvBloc;
        },
        act: (bloc) => bloc.add(WatchlistEvent()),
        expect: () => [
              WatchlistLoading(),
              const WatchlistError('Server Failure'),
            ],
        verify: (bloc) => verify(mockGetWatchlistTv.execute()));
  });
}
