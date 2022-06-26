import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/movie/movie.dart';
import 'package:core/domain/entities/tv/tv.dart';
import 'package:equatable/equatable.dart';
import 'package:watchlist/domain/usecases/movie/get_watchlist_movies.dart';
import 'package:watchlist/domain/usecases/tv/get_watchlist_tv.dart';

part 'watchlist_event.dart';
part 'watchlist_state.dart';

class WatchlistMoviesBloc extends Bloc<WatchlistEvent, WatchlistState> {
  final GetWatchlistMovies _getWatchlistMovies;

  WatchlistMoviesBloc(this._getWatchlistMovies) : super(WatchlistEmpty()) {
    on<WatchlistEvent>((event, emit) async {
      emit(WatchlistLoading());
      final result = await _getWatchlistMovies.execute();

      result.fold(
        (failure) {
          emit(WatchlistError(failure.message));
        },
        (data) {
          emit(WatchlistLoaded<Movie>(data));
        },
      );
    });
  }
}

class WatchlistTvBloc extends Bloc<WatchlistEvent, WatchlistState> {
  final GetWatchlistTv _getWatchlistTvs;

  WatchlistTvBloc(this._getWatchlistTvs) : super(WatchlistEmpty()) {
    on<WatchlistEvent>((event, emit) async {
      emit(WatchlistLoading());
      final result = await _getWatchlistTvs.execute();

      result.fold(
        (failure) {
          emit(WatchlistError(failure.message));
        },
        (data) {
          emit(WatchlistLoaded<Tv>(data));
        },
      );
    });
  }
}
