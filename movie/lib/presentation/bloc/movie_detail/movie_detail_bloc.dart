import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/movie/movie.dart';
import 'package:core/domain/entities/movie/movie_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/usecases/get_movie_detail.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';
import 'package:watchlist/domain/usecases/movie/get_watchlist_status.dart';
import 'package:watchlist/domain/usecases/movie/remove_watchlist.dart';
import 'package:watchlist/domain/usecases/movie/save_watchlist.dart';

part 'movie_detail_event.dart';

part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetMovieDetail getMovieDetail;
  final GetMovieRecommendations getMovieRecommendations;
  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;

  MovieDetailBloc({
    required this.getMovieDetail,
    required this.getMovieRecommendations,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(MovieDetailState.initial()) {
    on<FetchMovieDetail>(
      (event, emit) async {
        final id = event.id;

        emit(state.copyWith(movieState: RequestState.loading));
        final detailResult = await getMovieDetail.execute(id);
        final recommendationResult = await getMovieRecommendations.execute(id);

        detailResult.fold(
          (failure) async {
            emit(
              state.copyWith(
                movieState: RequestState.error,
                message: failure.message,
              ),
            );
          },
          (movie) async {
            emit(
              state.copyWith(
                recommendationState: RequestState.loading,
                movieDetail: movie,
                movieState: RequestState.loaded,
                message: '',
              ),
            );
            recommendationResult.fold(
              (failure) {
                emit(
                  state.copyWith(
                    recommendationState: RequestState.error,
                    message: failure.message,
                  ),
                );
              },
              (movies) {
                emit(
                  state.copyWith(
                    recommendationState: RequestState.loaded,
                    movieRecommendations: movies,
                    message: '',
                  ),
                );
              },
            );
          },
        );
      },
    );

    on<AddWatchlist>(
      (event, emit) async {
        final movie = event.movieDetail;

        final result = await saveWatchlist.execute(movie);

        result.fold(
          (failure) {
            emit(state.copyWith(watchlistMessage: failure.message));
          },
          (successMessage) async {
            emit(state.copyWith(watchlistMessage: successMessage));
          },
        );

        add(LoadWatchlistStatus(movie.id));
      },
    );

    on<RemoveFromWatchlist>(
      (event, emit) async {
        final movie = event.movieDetail;

        final result = await removeWatchlist.execute(movie);

        result.fold(
          (failure) {
            emit(state.copyWith(watchlistMessage: failure.message));
          },
          (successMessage) async {
            emit(state.copyWith(watchlistMessage: successMessage));
          },
        );

        add(LoadWatchlistStatus(movie.id));
      },
    );

    on<LoadWatchlistStatus>(
      (event, emit) async {
        final id = event.id;

        final result = await getWatchListStatus.execute(id);
        emit(state.copyWith(isAddedToWatchlist: result));
      },
    );
  }
}
