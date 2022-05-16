import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/movie/movie.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/usecases/get_movie_detail.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';
import 'package:movie/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:watchlist/domain/usecases/movie/get_watchlist_status.dart';
import 'package:watchlist/domain/usecases/movie/remove_watchlist.dart';
import 'package:watchlist/domain/usecases/movie/save_watchlist.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'movie_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetMovieDetail,
  GetMovieRecommendations,
  GetWatchListStatus,
  SaveWatchlist,
  RemoveWatchlist,
])
void main() {
  late MovieDetailBloc movieDetailBloc;
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late MockGetWatchListStatus mockGetWatchlistStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    mockGetWatchlistStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    movieDetailBloc = MovieDetailBloc(
      getMovieDetail: mockGetMovieDetail,
      getMovieRecommendations: mockGetMovieRecommendations,
      getWatchListStatus: mockGetWatchlistStatus,
      saveWatchlist: mockSaveWatchlist,
      removeWatchlist: mockRemoveWatchlist,
    );
  });

  const tId = 1;

  final movieStateInit = MovieDetailState.initial();
  final tMovies = <Movie>[testMovie];

  group('Get Movie Detail', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
        'should emit MovieDetailLoading, RecommendationLoading, MovieDetailLoaded and RecommendationLoaded when get Detail Movies and Recommendation Success',
        build: () {
          when(mockGetMovieDetail.execute(tId))
              .thenAnswer((_) async => const Right(testMovieDetail));
          when(mockGetMovieRecommendations.execute(tId))
              .thenAnswer((_) async => Right(tMovies));
          return movieDetailBloc;
        },
        act: (bloc) => bloc.add(const FetchMovieDetail(tId)),
        expect: () => [
              movieStateInit.copyWith(movieState: RequestState.loading),
              movieStateInit.copyWith(
                recommendationState: RequestState.loading,
                movieDetail: testMovieDetail,
                movieState: RequestState.loaded,
                message: '',
              ),
              movieStateInit.copyWith(
                movieState: RequestState.loaded,
                movieDetail: testMovieDetail,
                recommendationState: RequestState.loaded,
                movieRecommendations: tMovies,
                message: '',
              ),
            ],
        verify: (_) {
          verify(mockGetMovieDetail.execute(tId));
          verify(mockGetMovieRecommendations.execute(tId));
        });

    blocTest<MovieDetailBloc, MovieDetailState>(
        'should emit MovieDetailLoading, RecommendationLoading, MovieDetailLoaded and RecommendationError when get MovieRecommendations Failed',
        build: () {
          when(mockGetMovieDetail.execute(tId))
              .thenAnswer((_) async => const Right(testMovieDetail));
          when(mockGetMovieRecommendations.execute(tId))
              .thenAnswer((_) async => const Left(ConnectionFailure('Failed')));
          return movieDetailBloc;
        },
        act: (bloc) => bloc.add(const FetchMovieDetail(tId)),
        expect: () => [
              movieStateInit.copyWith(movieState: RequestState.loading),
              movieStateInit.copyWith(
                recommendationState: RequestState.loading,
                movieDetail: testMovieDetail,
                movieState: RequestState.loaded,
                message: '',
              ),
              movieStateInit.copyWith(
                movieState: RequestState.loaded,
                movieDetail: testMovieDetail,
                recommendationState: RequestState.error,
                message: 'Failed',
              ),
            ],
        verify: (_) {
          verify(mockGetMovieDetail.execute(tId));
          verify(mockGetMovieRecommendations.execute(tId));
        });

    blocTest<MovieDetailBloc, MovieDetailState>(
        'should emit MovieDetailError when Get Movie Detail Failed',
        build: () {
          when(mockGetMovieDetail.execute(tId))
              .thenAnswer((_) async => const Left(ConnectionFailure('Failed')));
          when(mockGetMovieRecommendations.execute(tId))
              .thenAnswer((_) async => Right(tMovies));
          return movieDetailBloc;
        },
        act: (bloc) => bloc.add(const FetchMovieDetail(tId)),
        expect: () => [
              movieStateInit.copyWith(movieState: RequestState.loading),
              movieStateInit.copyWith(
                movieState: RequestState.error,
                message: 'Failed',
              ),
            ],
        verify: (_) {
          verify(mockGetMovieDetail.execute(tId));
          verify(mockGetMovieRecommendations.execute(tId));
        });
  });

  group('AddWatchlist', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
        'should emit WatchlistMessage and isAddedToWatchlist True when Success AddWatchlist',
        build: () {
          when(mockSaveWatchlist.execute(testMovieDetail))
              .thenAnswer((_) async => const Right('Added to Watchlist'));
          when(mockGetWatchlistStatus.execute(testMovieDetail.id))
              .thenAnswer((_) async => true);
          return movieDetailBloc;
        },
        act: (bloc) => bloc.add(const AddWatchlist(testMovieDetail)),
        expect: () => [
              movieStateInit.copyWith(watchlistMessage: 'Added to Watchlist'),
              movieStateInit.copyWith(
                watchlistMessage: 'Added to Watchlist',
                isAddedToWatchlist: true,
              ),
            ],
        verify: (_) {
          verify(mockSaveWatchlist.execute(testMovieDetail));
          verify(mockGetWatchlistStatus.execute(testMovieDetail.id));
        });

    blocTest<MovieDetailBloc, MovieDetailState>(
        'should emit WatchlistMessage when Failed',
        build: () {
          when(mockSaveWatchlist.execute(testMovieDetail))
              .thenAnswer((_) async => const Left(DatabaseFailure('Failed')));
          when(mockGetWatchlistStatus.execute(testMovieDetail.id))
              .thenAnswer((_) async => false);
          return movieDetailBloc;
        },
        act: (bloc) => bloc.add(const AddWatchlist(testMovieDetail)),
        expect: () => [
              movieStateInit.copyWith(watchlistMessage: 'Failed'),
            ],
        verify: (_) {
          verify(mockSaveWatchlist.execute(testMovieDetail));
          verify(mockGetWatchlistStatus.execute(testMovieDetail.id));
        });
  });

  group('RemoveFromWatchlist', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
        'should emit WatchlistMessage and isAddedToWatchlist True when Success RemoveFromWatchlist',
        build: () {
          when(mockRemoveWatchlist.execute(testMovieDetail))
              .thenAnswer((_) async => const Right('Removed From Watchlist'));
          when(mockGetWatchlistStatus.execute(testMovieDetail.id))
              .thenAnswer((_) async => false);
          return movieDetailBloc;
        },
        act: (bloc) => bloc.add(const RemoveFromWatchlist(testMovieDetail)),
        expect: () => [
              movieStateInit.copyWith(
                  watchlistMessage: 'Removed From Watchlist'),
            ],
        verify: (_) {
          verify(mockRemoveWatchlist.execute(testMovieDetail));
          verify(mockGetWatchlistStatus.execute(testMovieDetail.id));
        });

    blocTest<MovieDetailBloc, MovieDetailState>(
        'should emit WatchlistMessage when Failed',
        build: () {
          when(mockRemoveWatchlist.execute(testMovieDetail))
              .thenAnswer((_) async => const Left(DatabaseFailure('Failed')));
          when(mockGetWatchlistStatus.execute(testMovieDetail.id))
              .thenAnswer((_) async => false);
          return movieDetailBloc;
        },
        act: (bloc) => bloc.add(const RemoveFromWatchlist(testMovieDetail)),
        expect: () => [
              movieStateInit.copyWith(watchlistMessage: 'Failed'),
            ],
        verify: (_) {
          verify(mockRemoveWatchlist.execute(testMovieDetail));
          verify(mockGetWatchlistStatus.execute(testMovieDetail.id));
        });
  });

  group('LoadWatchlistStatus', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
        'should emit AddWatchlistStatus true',
        build: () {
          when(mockGetWatchlistStatus.execute(tId))
              .thenAnswer((_) async => true);
          return movieDetailBloc;
        },
        act: (bloc) => bloc.add(const LoadWatchlistStatus(tId)),
        expect: () => [
              movieStateInit.copyWith(isAddedToWatchlist: true),
            ],
        verify: (_) {
          verify(mockGetWatchlistStatus.execute(testMovieDetail.id));
        });
  });
}
