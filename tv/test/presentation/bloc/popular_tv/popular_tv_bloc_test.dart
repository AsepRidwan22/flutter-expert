import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/tv/tv.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/get_popular_tv.dart';
import 'package:tv/presentation/bloc/popular_tvs_bloc.dart';
import 'package:tv/presentation/bloc/tv_event.dart';
import 'package:tv/presentation/bloc/tv_state.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'popular_tv_bloc_test.mocks.dart';

@GenerateMocks([GetPopularTv])
void main() {
  late MockGetPopularTv mockGetPopularTv;
  late PopularTvBloc popularTvBloc;

  setUp(() {
    mockGetPopularTv = MockGetPopularTv();
    popularTvBloc = PopularTvBloc(mockGetPopularTv);
  });

  final tTvList = <Tv>[testTv];

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
        'should emit [TvLoading, TvLoaded[]] when data is gotten successfully',
        build: () {
          when(mockGetPopularTv.execute())
              .thenAnswer((_) async => const Right(<Tv>[]));
          return popularTvBloc;
        },
        act: (bloc) => bloc.add(TvGetEvent()),
        expect: () => [
              TvLoading(),
              const TvLoaded(<Tv>[]),
            ],
        verify: (bloc) => verify(mockGetPopularTv.execute()));

    blocTest<PopularTvBloc, TvState>(
        'should emit [TvLoading, TvError] when data is unsuccessful',
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
}
