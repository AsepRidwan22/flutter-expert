import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/tv/tv.dart';
import 'package:core/domain/entities/tv/tv_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/domain/usecases/get_tv_detail.dart';
import 'package:tv/domain/usecases/get_tv_recommendations.dart';
import 'package:watchlist/domain/usecases/tv/get_watchlist_status.dart';
import 'package:watchlist/domain/usecases/tv/remove_watchlist.dart';
import 'package:watchlist/domain/usecases/tv/save_watchlist.dart';

part 'tv_detail_event.dart';

part 'tv_detail_state.dart';

class TvDetailBloc extends Bloc<TvDetailEvent, TvDetailState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetTvDetail getTvDetail;
  final GetTvRecommendation getTvRecommendation;
  final GetWatchListStatusTv getWatchListStatus;
  final SaveWatchlistTv saveWatchlist;
  final RemoveWatchlistTv removeWatchlist;

  TvDetailBloc({
    required this.getTvDetail,
    required this.getTvRecommendation,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(TvDetailState.initial()) {
    on<FetchTvDetail>(
      (event, emit) async {
        final id = event.id;

        emit(state.copyWith(tvState: RequestState.loading));
        final detailResult = await getTvDetail.execute(id);
        final recommendationResult = await getTvRecommendation.execute(id);

        detailResult.fold(
          (failure) async {
            emit(
              state.copyWith(
                tvState: RequestState.error,
                message: failure.message,
              ),
            );
          },
          (tv) async {
            emit(
              state.copyWith(
                recommendationState: RequestState.loading,
                tvDetail: tv,
                tvState: RequestState.loaded,
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
              (tvs) {
                emit(
                  state.copyWith(
                    recommendationState: RequestState.loaded,
                    tvRecommendations: tvs,
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
        final tv = event.tvDetail;

        final result = await saveWatchlist.execute(tv);

        result.fold(
          (failure) {
            emit(state.copyWith(watchlistMessage: failure.message));
          },
          (successMessage) async {
            emit(state.copyWith(watchlistMessage: successMessage));
          },
        );

        add(LoadWatchlistStatus(tv.id));
      },
    );

    on<RemoveFromWatchlist>(
      (event, emit) async {
        final tv = event.tvDetail;

        final result = await removeWatchlist.execute(tv);

        result.fold(
          (failure) {
            emit(state.copyWith(watchlistMessage: failure.message));
          },
          (successMessage) async {
            emit(state.copyWith(watchlistMessage: successMessage));
          },
        );

        add(LoadWatchlistStatus(tv.id));
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
