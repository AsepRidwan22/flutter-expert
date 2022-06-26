import 'package:bloc/bloc.dart';
import 'package:tv/domain/usecases/get_now_playing_tv.dart';
import 'package:tv/presentation/bloc/tv_event.dart';
import 'package:tv/presentation/bloc/tv_state.dart';

class TvListBloc extends Bloc<TvEvent, TvState> {
  final GetNowPlayingTv _getNowPlayingTv;

  TvListBloc(this._getNowPlayingTv) : super(TvEmpty()) {
    on<TvGetEvent>((event, emit) async {
      emit(TvLoading());
      final result = await _getNowPlayingTv.execute();

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
