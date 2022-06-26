import 'package:bloc/bloc.dart';
import 'package:tv/domain/usecases/get_top_rated_tv.dart';
import 'package:tv/presentation/bloc/tv_event.dart';
import 'package:tv/presentation/bloc/tv_state.dart';

class TopRatedTvsBloc extends Bloc<TvEvent, TvState> {
  final GetTopRatedTv _getTopRatedTv;

  TopRatedTvsBloc(this._getTopRatedTv) : super(TvEmpty()) {
    on<TvGetEvent>((event, emit) async {
      emit(TvLoading());
      final result = await _getTopRatedTv.execute();

      result.fold(
        (failure) {
          emit(TvError(failure.message));
        },
        (data) {
          emit(TvLoaded(data));
        },
      );
    });
  }
}
