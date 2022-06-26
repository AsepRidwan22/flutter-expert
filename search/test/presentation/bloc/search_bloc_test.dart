import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/movie/movie.dart';
import 'package:core/domain/entities/tv/tv.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:search/presentation/bloc/search_bloc.dart';
import 'package:search/search.dart';

import 'search_bloc_test.mocks.dart';

@GenerateMocks([SearchMovies, SearchTv])
void main() {
  late SearchMovieBloc searchMovieBloc;
  late SearchTvBloc searchTvBloc;
  late MockSearchMovies mockSearchMovies;
  late MockSearchTv mockSearchTv;

  setUp(() {
    mockSearchMovies = MockSearchMovies();
    mockSearchTv = MockSearchTv();
    searchMovieBloc = SearchMovieBloc(mockSearchMovies);
    searchTvBloc = SearchTvBloc(mockSearchTv);
  });

  final tMovieModel = Movie(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: const [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );
  final tMovieList = <Movie>[tMovieModel];
  const tQueryMovie = 'spiderman';

  group('search movies', () {
    test('initial state should be empty', () {
      expect(searchMovieBloc.state, SearchEmpty());
    });

    blocTest<SearchMovieBloc, SearchState>(
        'Should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(mockSearchMovies.execute(tQueryMovie))
              .thenAnswer((_) async => Right(tMovieList));
          return searchMovieBloc;
        },
        act: (bloc) => bloc.add(const OnQueryChanged(tQueryMovie)),
        wait: const Duration(milliseconds: 500),
        expect: () => [
              SearchLoading(),
              SearchLoaded(tMovieList),
            ],
        verify: (bloc) {
          verify(mockSearchMovies.execute(tQueryMovie));
        });

    blocTest<SearchMovieBloc, SearchState>(
        'Should emit [Loading, Error] when get search is unsuccessful',
        build: () {
          when(mockSearchMovies.execute(tQueryMovie)).thenAnswer(
              (_) async => const Left(ServerFailure('Server Failure')));
          return searchMovieBloc;
        },
        act: (bloc) => bloc.add(const OnQueryChanged(tQueryMovie)),
        wait: const Duration(milliseconds: 500),
        expect: () => [
              SearchLoading(),
              const SearchError('Server Failure'),
            ],
        verify: (bloc) {
          verify(mockSearchMovies.execute(tQueryMovie));
        });
  });

  final tTvModel = Tv(
    id: 52814,
    name: 'Halo',
    overview:
        'Depicting an epic 26th-century conflict between humanity and an alien threat known as the Covenant, the series weaves deeply drawn personal stories with action, adventure and a richly imagined vision of the future.',
    posterPath: '/nJUHX3XL1jMkk8honUZnUmudFb9.jpg',
  );
  final tTvList = <Tv>[tTvModel];
  const tQueryTv = 'halo';

  group('Search tvs', () {
    test('initial state should be empty', () {
      expect(searchMovieBloc.state, SearchEmpty());
    });

    blocTest<SearchTvBloc, SearchState>(
        'Should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(mockSearchTv.execute(tQueryTv))
              .thenAnswer((_) async => Right(tTvList));
          return searchTvBloc;
        },
        act: (bloc) => bloc.add(const OnQueryChanged(tQueryTv)),
        wait: const Duration(milliseconds: 500),
        expect: () => [
              SearchLoading(),
              SearchLoaded(tTvList),
            ],
        verify: (bloc) {
          verify(mockSearchTv.execute(tQueryTv));
        });

    blocTest<SearchTvBloc, SearchState>(
        'Should emit [Loading, Error] when get search is unsuccessful',
        build: () {
          when(mockSearchTv.execute(tQueryTv)).thenAnswer(
              (_) async => const Left(ServerFailure('Server Failure')));
          return searchTvBloc;
        },
        act: (bloc) => bloc.add(const OnQueryChanged(tQueryTv)),
        wait: const Duration(milliseconds: 500),
        expect: () => [
              SearchLoading(),
              const SearchError('Server Failure'),
            ],
        verify: (bloc) {
          verify(mockSearchTv.execute(tQueryTv));
        });
  });
}
