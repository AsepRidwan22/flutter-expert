import 'package:bloc/bloc.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';
import 'package:movie/presentation/bloc/movie_event.dart';
import 'package:movie/presentation/bloc/movie_state.dart';

class TopRatedMoviesBloc extends Bloc<MovieEvent, MovieState> {
  final GetTopRatedMovies _getTopRatedMovies;

  TopRatedMoviesBloc(this._getTopRatedMovies) : super(MovieEmpty()) {
    on<MovieGetEvent>((event, emit) async {
      emit(MovieLoading());
      final result = await _getTopRatedMovies.execute();

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
