import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/movie/movie.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';
import 'package:movie/presentation/bloc/movie_event.dart';
import 'package:movie/presentation/bloc/movie_state.dart';
import 'package:movie/presentation/bloc/popular_movies_bloc.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'popular_movies_bloc_test.mocks.dart';

@GenerateMocks([GetPopularMovies])
void main() {
  late MockGetPopularMovies mockGetPopularMovies;
  late PopularMoviesBloc popularMoviesBloc;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    popularMoviesBloc = PopularMoviesBloc(mockGetPopularMovies);
  });

  final tMovieList = <Movie>[testMovie];

  group('popular movies', () {
    test('initialState should be Empty', () {
      expect(popularMoviesBloc.state, MovieEmpty());
    });

    blocTest<PopularMoviesBloc, MovieState>(
        'should emit [MovieLoading, MovieLoaded] when data is gotten successfully',
        build: () {
          when(mockGetPopularMovies.execute())
              .thenAnswer((_) async => Right(tMovieList));
          return popularMoviesBloc;
        },
        act: (bloc) => bloc.add(MovieGetEvent()),
        expect: () => [
              MovieLoading(),
              MovieLoaded(tMovieList),
            ],
        verify: (bloc) => verify(mockGetPopularMovies.execute()));

    blocTest<PopularMoviesBloc, MovieState>(
        'should emit [MovieLoading, MovieLoaded[]] when data is gotten successfully',
        build: () {
          when(mockGetPopularMovies.execute())
              .thenAnswer((_) async => const Right(<Movie>[]));
          return popularMoviesBloc;
        },
        act: (bloc) => bloc.add(MovieGetEvent()),
        expect: () => [
              MovieLoading(),
              const MovieLoaded(<Movie>[]),
            ],
        verify: (bloc) => verify(mockGetPopularMovies.execute()));

    blocTest<PopularMoviesBloc, MovieState>(
        'should emit [MovieLoading, MovieError] when data is unsuccessful',
        build: () {
          when(mockGetPopularMovies.execute())
              .thenAnswer((_) async => const Left(ServerFailure('Failed')));
          return popularMoviesBloc;
        },
        act: (bloc) => bloc.add(MovieGetEvent()),
        expect: () => [
              MovieLoading(),
              const MovieError('Failed'),
            ],
        verify: (bloc) => verify(mockGetPopularMovies.execute()));
  });
}
