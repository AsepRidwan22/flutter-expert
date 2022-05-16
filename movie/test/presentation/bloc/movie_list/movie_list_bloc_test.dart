import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/movie/movie.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/usecases/get_now_playing_movies.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';
import 'package:movie/presentation/bloc/movie_event.dart';
import 'package:movie/presentation/bloc/movie_list_bloc.dart';
import 'package:movie/presentation/bloc/movie_state.dart';
import 'package:movie/presentation/bloc/popular_movies_bloc.dart';
import 'package:movie/presentation/bloc/top_rated_movies_bloc.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'movie_list_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingMovies, GetPopularMovies, GetTopRatedMovies])
void main() {
  late MovieListBloc listBloc;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late PopularMoviesBloc popularMoviesBloc;
  late MockGetPopularMovies mockGetPopularMovies;
  late TopRatedMoviesBloc topRatedMoviesBloc;
  late MockGetTopRatedMovies mockGetTopRatedMovies;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    listBloc = MovieListBloc(mockGetNowPlayingMovies);
    mockGetPopularMovies = MockGetPopularMovies();
    popularMoviesBloc = PopularMoviesBloc(mockGetPopularMovies);
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    topRatedMoviesBloc = TopRatedMoviesBloc(mockGetTopRatedMovies);
  });

  final tMovieList = <Movie>[testMovie];

  group('now playing movies', () {
    test('initialState should be Empty', () {
      expect(listBloc.state, MovieEmpty());
    });

    blocTest<MovieListBloc, MovieState>(
        'should emit [MovieLoading, MovieLoaded] when data is gotten successfully',
        build: () {
          when(mockGetNowPlayingMovies.execute())
              .thenAnswer((_) async => Right(tMovieList));
          return listBloc;
        },
        act: (bloc) => bloc.add(MovieGetEvent()),
        expect: () => [
              MovieLoading(),
              MovieLoaded(tMovieList),
            ],
        verify: (bloc) => verify(mockGetNowPlayingMovies.execute()));

    blocTest<MovieListBloc, MovieState>(
        'should emit [MovieLoading, MovieLoaded] when data is unsuccessful',
        build: () {
          when(mockGetNowPlayingMovies.execute())
              .thenAnswer((_) async => const Left(ServerFailure('Failed')));
          return listBloc;
        },
        act: (bloc) => bloc.add(MovieGetEvent()),
        expect: () => [
              MovieLoading(),
              const MovieError('Failed'),
            ],
        verify: (bloc) => verify(mockGetNowPlayingMovies.execute()));
  });

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
        'should emit [MovieLoading, MovieLoaded] when data is unsuccessful',
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
        'should emit [MovieLoading, MovieLoaded] when data is unsuccessful',
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
