import 'package:bloc/bloc.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';
import 'package:movie/presentation/bloc/movie_event.dart';
import 'package:movie/presentation/bloc/movie_state.dart';

class PopularMoviesBloc extends Bloc<MovieEvent, MovieState> {
  final GetPopularMovies _getPopularMovies;

  PopularMoviesBloc(this._getPopularMovies) : super(MovieEmpty()) {
    on<MovieGetEvent>((event, emit) async {
      emit(MovieLoading());
      final result = await _getPopularMovies.execute();

      result.fold(
        (failure) {
          emit(MovieError(failure.message));
        },
        (data) {
          emit(MovieLoaded(data));
        },
      );
    });
  }
}
