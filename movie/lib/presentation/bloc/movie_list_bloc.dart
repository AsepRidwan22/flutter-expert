import 'package:bloc/bloc.dart';
import 'package:movie/domain/usecases/get_now_playing_movies.dart';
import 'package:movie/presentation/bloc/movie_event.dart';
import 'package:movie/presentation/bloc/movie_state.dart';

class MovieListBloc extends Bloc<MovieEvent, MovieState> {
  final GetNowPlayingMovies _getNowPlayingMovies;

  MovieListBloc(this._getNowPlayingMovies) : super(MovieEmpty()) {
    on<MovieGetEvent>((event, emit) async {
      emit(MovieLoading());
      final result = await _getNowPlayingMovies.execute();

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
