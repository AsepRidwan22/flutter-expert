import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/tv/tv.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/get_now_playing_tv.dart';
import 'package:tv/domain/usecases/get_popular_tv.dart';
import 'package:tv/domain/usecases/get_top_rated_tv.dart';
import 'package:tv/presentation/bloc/popular_tvs_bloc.dart';
import 'package:tv/presentation/bloc/top_rated_tvs_bloc.dart';
import 'package:tv/presentation/bloc/tv_event.dart';
import 'package:tv/presentation/bloc/tv_list_bloc.dart';
import 'package:tv/presentation/bloc/tv_state.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_list_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingTv, GetPopularTv, GetTopRatedTv])
void main() {
  late TvListBloc listBloc;
  late MockGetNowPlayingTv mockGetNowPlayingTv;
  late PopularTvBloc popularTvBloc;
  late MockGetPopularTv mockGetPopularTv;
  late TopRatedTvsBloc topRatedTvsBloc;
  late MockGetTopRatedTv mockGetTopRatedTv;

  setUp(() {
    mockGetNowPlayingTv = MockGetNowPlayingTv();
    listBloc = TvListBloc(mockGetNowPlayingTv);
    mockGetPopularTv = MockGetPopularTv();
    popularTvBloc = PopularTvBloc(mockGetPopularTv);
    mockGetTopRatedTv = MockGetTopRatedTv();
    topRatedTvsBloc = TopRatedTvsBloc(mockGetTopRatedTv);
  });

  final tTvList = <Tv>[testTv];

  group('now playing tvs', () {
    test('initialState should be Empty', () {
      expect(listBloc.state, TvEmpty());
    });

    blocTest<TvListBloc, TvState>(
        'should emit [TvLoading, TvLoaded] when data is gotten successfully',
        build: () {
          when(mockGetNowPlayingTv.execute())
              .thenAnswer((_) async => Right(tTvList));
          return listBloc;
        },
        act: (bloc) => bloc.add(TvGetEvent()),
        expect: () => [
              TvLoading(),
              TvLoaded(tTvList),
            ],
        verify: (bloc) => verify(mockGetNowPlayingTv.execute()));

    blocTest<TvListBloc, TvState>(
        'should emit [TvLoading, TvLoaded] when data is unsuccessful',
        build: () {
          when(mockGetNowPlayingTv.execute())
              .thenAnswer((_) async => const Left(ServerFailure('Failed')));
          return listBloc;
        },
        act: (bloc) => bloc.add(TvGetEvent()),
        expect: () => [
              TvLoading(),
              const TvError('Failed'),
            ],
        verify: (bloc) => verify(mockGetNowPlayingTv.execute()));
  });

  group('popular tvs', () {
    test('initialState should be Empty', () {
      expect(popularTvBloc.state, TvEmpty());
    });

    blocTest<PopularTvBloc, TvState>(
        'should emit [TvLoading, TvLoaded] when data is gotten successfully',
        build: () {
          when(mockGetPopularTv.execute())
              .thenAnswer((_) async => Right(tTvList));
          return popularTvBloc;
        },
        act: (bloc) => bloc.add(TvGetEvent()),
        expect: () => [
              TvLoading(),
              TvLoaded(tTvList),
            ],
        verify: (bloc) => verify(mockGetPopularTv.execute()));

    blocTest<PopularTvBloc, TvState>(
        'should emit [TvLoading, TvLoaded] when data is unsuccessful',
        build: () {
          when(mockGetPopularTv.execute())
              .thenAnswer((_) async => const Left(ServerFailure('Failed')));
          return popularTvBloc;
        },
        act: (bloc) => bloc.add(TvGetEvent()),
        expect: () => [
              TvLoading(),
              const TvError('Failed'),
            ],
        verify: (bloc) => verify(mockGetPopularTv.execute()));
  });

  group('top rated tvs', () {
    test('initialState should be Empty', () {
      expect(topRatedTvsBloc.state, TvEmpty());
    });

    blocTest<TopRatedTvsBloc, TvState>(
        'should emit [TvLoading, TvLoaded] when data is gotten successfully',
        build: () {
          when(mockGetTopRatedTv.execute())
              .thenAnswer((_) async => Right(tTvList));
          return topRatedTvsBloc;
        },
        act: (bloc) => bloc.add(TvGetEvent()),
        expect: () => [
              TvLoading(),
              TvLoaded(tTvList),
            ],
        verify: (bloc) => verify(mockGetTopRatedTv.execute()));

    blocTest<TopRatedTvsBloc, TvState>(
        'should emit [TvLoading, TvLoaded] when data is unsuccessful',
        build: () {
          when(mockGetTopRatedTv.execute())
              .thenAnswer((_) async => const Left(ServerFailure('Failed')));
          return topRatedTvsBloc;
        },
        act: (bloc) => bloc.add(TvGetEvent()),
        expect: () => [
              TvLoading(),
              const TvError('Failed'),
            ],
        verify: (bloc) => verify(mockGetTopRatedTv.execute()));
  });
}
