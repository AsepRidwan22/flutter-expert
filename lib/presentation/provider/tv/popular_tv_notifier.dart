import 'package:proyek_awal/common/state_enum.dart';
import 'package:proyek_awal/domain/entities/tv/tv.dart';
import 'package:proyek_awal/domain/usecases/tv/get_popular_tv.dart';
import 'package:flutter/foundation.dart';

class PopularTvNotifier extends ChangeNotifier {
  final GetPopularTv getPopularTv;

  PopularTvNotifier(this.getPopularTv);

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  List<Tv> _tv = [];
  List<Tv> get tv => _tv;

  String _message = '';
  String get message => _message;

  Future<void> fetchPopularTv() async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getPopularTv.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
        notifyListeners();
      },
      (tvsData) {
        _tv = tvsData;
        _state = RequestState.loaded;
        notifyListeners();
      },
    );
  }
}
