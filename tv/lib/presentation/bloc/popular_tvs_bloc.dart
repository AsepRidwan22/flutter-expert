import 'package:bloc/bloc.dart';
import 'package:tv/domain/usecases/get_popular_tv.dart';
import 'package:tv/presentation/bloc/tv_event.dart';
import 'package:tv/presentation/bloc/tv_state.dart';

class PopularTvBloc extends Bloc<TvEvent, TvState> {
  final GetPopularTv _getPopularTv;

  PopularTvBloc(this._getPopularTv) : super(TvEmpty()) {
    on<TvGetEvent>((event, emit) async {
      emit(TvLoading());
      final result = await _getPopularTv.execute();

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
