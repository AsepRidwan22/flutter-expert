import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/tv/tv.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/get_tv_detail.dart';
import 'package:tv/domain/usecases/get_tv_recommendations.dart';
import 'package:tv/presentation/bloc/tv_detail/tv_detail_bloc.dart';
import 'package:watchlist/domain/usecases/tv/get_watchlist_status.dart';
import 'package:watchlist/domain/usecases/tv/remove_watchlist.dart';
import 'package:watchlist/domain/usecases/tv/save_watchlist.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetTvDetail,
  GetTvRecommendation,
  GetWatchListStatusTv,
  SaveWatchlistTv,
  RemoveWatchlistTv,
])
void main() {
  late TvDetailBloc tvDetailBloc;
  late MockGetTvDetail mockGetTvDetail;
  late MockGetTvRecommendation mockGetTvRecommendation;
  late MockGetWatchListTvStatus mockGetWatchlistStatus;
  late MockSaveWatchlistTv mockSaveWatchlist;
  late MockRemoveWatchlistTv mockRemoveWatchlist;

  setUp(() {
    mockGetTvDetail = MockGetTvDetail();
    mockGetTvRecommendation = MockGetTvRecommendation();
    mockGetWatchlistStatus = MockGetWatchListTvStatus();
    mockSaveWatchlist = MockSaveWatchlistTv();
    mockRemoveWatchlist = MockRemoveWatchlistTv();
    tvDetailBloc = TvDetailBloc(
      getTvDetail: mockGetTvDetail,
      getTvRecommendation: mockGetTvRecommendation,
      getWatchListStatus: mockGetWatchlistStatus,
      saveWatchlist: mockSaveWatchlist,
      removeWatchlist: mockRemoveWatchlist,
    );
  });

  const tId = 1;

  final tvStateInit = TvDetailState.initial();
  final tTvs = <Tv>[testTv];

  group('Get Tv Detail', () {
    blocTest<TvDetailBloc, TvDetailState>(
        'should emit TvDetailLoading, RecommendationLoading, TvDetailLoaded and RecommendationLoaded when get Detail Tvs and Recommendation Success',
        build: () {
          when(mockGetTvDetail.execute(tId))
              .thenAnswer((_) async => const Right(testTvDetail));
          when(mockGetTvRecommendation.execute(tId))
              .thenAnswer((_) async => Right(tTvs));
          return tvDetailBloc;
        },
        act: (bloc) => bloc.add(const FetchTvDetail(tId)),
        expect: () => [
              tvStateInit.copyWith(tvState: RequestState.loading),
              tvStateInit.copyWith(
                recommendationState: RequestState.loading,
                tvDetail: testTvDetail,
                tvState: RequestState.loaded,
                message: '',
              ),
              tvStateInit.copyWith(
                tvState: RequestState.loaded,
                tvDetail: testTvDetail,
                recommendationState: RequestState.loaded,
                tvRecommendations: tTvs,
                message: '',
              ),
            ],
        verify: (_) {
          verify(mockGetTvDetail.execute(tId));
          verify(mockGetTvRecommendation.execute(tId));
        });

    blocTest<TvDetailBloc, TvDetailState>(
        'should emit TvDetailLoading, RecommendationLoading, TvDetailLoaded and RecommendationError when get TvRecommendations Failed',
        build: () {
          when(mockGetTvDetail.execute(tId))
              .thenAnswer((_) async => const Right(testTvDetail));
          when(mockGetTvRecommendation.execute(tId))
              .thenAnswer((_) async => const Left(ConnectionFailure('Failed')));
          return tvDetailBloc;
        },
        act: (bloc) => bloc.add(const FetchTvDetail(tId)),
        expect: () => [
              tvStateInit.copyWith(tvState: RequestState.loading),
              tvStateInit.copyWith(
                recommendationState: RequestState.loading,
                tvDetail: testTvDetail,
                tvState: RequestState.loaded,
                message: '',
              ),
              tvStateInit.copyWith(
                tvState: RequestState.loaded,
                tvDetail: testTvDetail,
                recommendationState: RequestState.error,
                message: 'Failed',
              ),
            ],
        verify: (_) {
          verify(mockGetTvDetail.execute(tId));
          verify(mockGetTvRecommendation.execute(tId));
        });

    blocTest<TvDetailBloc, TvDetailState>(
        'should emit TvDetailError when Get Tv Detail Failed',
        build: () {
          when(mockGetTvDetail.execute(tId))
              .thenAnswer((_) async => const Left(ConnectionFailure('Failed')));
          when(mockGetTvRecommendation.execute(tId))
              .thenAnswer((_) async => Right(tTvs));
          return tvDetailBloc;
        },
        act: (bloc) => bloc.add(const FetchTvDetail(tId)),
        expect: () => [
              tvStateInit.copyWith(tvState: RequestState.loading),
              tvStateInit.copyWith(
                tvState: RequestState.error,
                message: 'Failed',
              ),
            ],
        verify: (_) {
          verify(mockGetTvDetail.execute(tId));
          verify(mockGetTvRecommendation.execute(tId));
        });
  });

  group('AddWatchlist', () {
    blocTest<TvDetailBloc, TvDetailState>(
        'should emit WatchlistMessage and isAddedToWatchlist True when Success AddWatchlist',
        build: () {
          when(mockSaveWatchlist.execute(testTvDetail))
              .thenAnswer((_) async => const Right('Added to Watchlist'));
          when(mockGetWatchlistStatus.execute(testTvDetail.id))
              .thenAnswer((_) async => true);
          return tvDetailBloc;
        },
        act: (bloc) => bloc.add(const AddWatchlist(testTvDetail)),
        expect: () => [
              tvStateInit.copyWith(watchlistMessage: 'Added to Watchlist'),
              tvStateInit.copyWith(
                watchlistMessage: 'Added to Watchlist',
                isAddedToWatchlist: true,
              ),
            ],
        verify: (_) {
          verify(mockSaveWatchlist.execute(testTvDetail));
          verify(mockGetWatchlistStatus.execute(testTvDetail.id));
        });

    blocTest<TvDetailBloc, TvDetailState>(
        'should emit WatchlistMessage when Failed',
        build: () {
          when(mockSaveWatchlist.execute(testTvDetail))
              .thenAnswer((_) async => const Left(DatabaseFailure('Failed')));
          when(mockGetWatchlistStatus.execute(testTvDetail.id))
              .thenAnswer((_) async => false);
          return tvDetailBloc;
        },
        act: (bloc) => bloc.add(const AddWatchlist(testTvDetail)),
        expect: () => [
              tvStateInit.copyWith(watchlistMessage: 'Failed'),
            ],
        verify: (_) {
          verify(mockSaveWatchlist.execute(testTvDetail));
          verify(mockGetWatchlistStatus.execute(testTvDetail.id));
        });
  });

  group('RemoveFromWatchlist', () {
    blocTest<TvDetailBloc, TvDetailState>(
        'should emit WatchlistMessage and isAddedToWatchlist True when Success RemoveFromWatchlist',
        build: () {
          when(mockRemoveWatchlist.execute(testTvDetail))
              .thenAnswer((_) async => const Right('Removed From Watchlist'));
          when(mockGetWatchlistStatus.execute(testTvDetail.id))
              .thenAnswer((_) async => false);
          return tvDetailBloc;
        },
        act: (bloc) => bloc.add(const RemoveFromWatchlist(testTvDetail)),
        expect: () => [
              tvStateInit.copyWith(watchlistMessage: 'Removed From Watchlist'),
            ],
        verify: (_) {
          verify(mockRemoveWatchlist.execute(testTvDetail));
          verify(mockGetWatchlistStatus.execute(testTvDetail.id));
        });

    blocTest<TvDetailBloc, TvDetailState>(
        'should emit WatchlistMessage when Failed',
        build: () {
          when(mockRemoveWatchlist.execute(testTvDetail))
              .thenAnswer((_) async => const Left(DatabaseFailure('Failed')));
          when(mockGetWatchlistStatus.execute(testTvDetail.id))
              .thenAnswer((_) async => false);
          return tvDetailBloc;
        },
        act: (bloc) => bloc.add(const RemoveFromWatchlist(testTvDetail)),
        expect: () => [
              tvStateInit.copyWith(watchlistMessage: 'Failed'),
            ],
        verify: (_) {
          verify(mockRemoveWatchlist.execute(testTvDetail));
          verify(mockGetWatchlistStatus.execute(testTvDetail.id));
        });
  });

  group('LoadWatchlistStatus', () {
    blocTest<TvDetailBloc, TvDetailState>('should emit AddWatchlistStatus true',
        build: () {
          when(mockGetWatchlistStatus.execute(tId))
              .thenAnswer((_) async => true);
          return tvDetailBloc;
        },
        act: (bloc) => bloc.add(const LoadWatchlistStatus(tId)),
        expect: () => [
              tvStateInit.copyWith(isAddedToWatchlist: true),
            ],
        verify: (_) {
          verify(mockGetWatchlistStatus.execute(testTvDetail.id));
        });
  });
}
