import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/tv/tv.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/get_top_rated_tv.dart';
import 'package:tv/presentation/bloc/top_rated_tvs_bloc.dart';
import 'package:tv/presentation/bloc/tv_event.dart';
import 'package:tv/presentation/bloc/tv_state.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'top_rated_tv_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedTv])
void main() {
  late MockGetTopRatedTv mockGetTopRatedTv;
  late TopRatedTvsBloc topRatedTvsBloc;

  setUp(() {
    mockGetTopRatedTv = MockGetTopRatedTv();
    topRatedTvsBloc = TopRatedTvsBloc(mockGetTopRatedTv);
  });

  final tTvList = <Tv>[testTv];

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
        'should emit [TvLoading, TvLoaded[]] when data is gotten successfully',
        build: () {
          when(mockGetTopRatedTv.execute())
              .thenAnswer((_) async => const Right(<Tv>[]));
          return topRatedTvsBloc;
        },
        act: (bloc) => bloc.add(TvGetEvent()),
        expect: () => [
              TvLoading(),
              const TvLoaded(<Tv>[]),
            ],
        verify: (bloc) => verify(mockGetTopRatedTv.execute()));

    blocTest<TopRatedTvsBloc, TvState>(
        'should emit [TvLoading, TvError] when data is unsuccessful',
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
