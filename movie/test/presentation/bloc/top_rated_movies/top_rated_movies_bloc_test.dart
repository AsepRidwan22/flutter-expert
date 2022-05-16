import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/movie/movie.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';
import 'package:movie/presentation/bloc/movie_event.dart';
import 'package:movie/presentation/bloc/movie_state.dart';
import 'package:movie/presentation/bloc/top_rated_movies_bloc.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'top_rated_movies_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedMovies])
void main() {
  late MockGetTopRatedMovies mockGetTopRatedMovies;
  late TopRatedMoviesBloc topRatedMoviesBloc;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    topRatedMoviesBloc = TopRatedMoviesBloc(mockGetTopRatedMovies);
  });

  final tMovieList = <Movie>[testMovie];

  group('top rated movies', () {
    test('initialState should be Empty', () {
      expect(topRatedMoviesBloc.state, MovieEmpty());
    });

    blocTest<TopRatedMoviesBloc, MovieState>(
        'should emit [MovieLoading, MovieLoaded] when data is gotten successfully',
        build: () {
          when(mockGetTopRatedMovies.execute())
              .thenAnswer((_) async => Right(tMovieList));
          return topRatedMoviesBloc;
        },
        act: (bloc) => bloc.add(MovieGetEvent()),
        expect: () => [
              MovieLoading(),
              MovieLoaded(tMovieList),
            ],
        verify: (bloc) => verify(mockGetTopRatedMovies.execute()));

    blocTest<TopRatedMoviesBloc, MovieState>(
        'should emit [MovieLoading, MovieLoaded[]] when data is gotten successfully',
        build: () {
          when(mockGetTopRatedMovies.execute())
              .thenAnswer((_) async => const Right(<Movie>[]));
          return topRatedMoviesBloc;
        },
        act: (bloc) => bloc.add(MovieGetEvent()),
        expect: () => [
              MovieLoading(),
              const MovieLoaded(<Movie>[]),
            ],
        verify: (bloc) => verify(mockGetTopRatedMovies.execute()));

    blocTest<TopRatedMoviesBloc, MovieState>(
        'should emit [MovieLoading, MovieError] when data is unsuccessful',
        build: () {
          when(mockGetTopRatedMovies.execute())
              .thenAnswer((_) async => const Left(ServerFailure('Failed')));
          return topRatedMoviesBloc;
        },
        act: (bloc) => bloc.add(MovieGetEvent()),
        expect: () => [
              MovieLoading(),
              const MovieError('Failed'),
            ],
        verify: (bloc) => verify(mockGetTopRatedMovies.execute()));
  });
}
