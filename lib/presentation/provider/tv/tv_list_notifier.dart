import 'package:proyek_awal/domain/entities/tv/tv.dart';
import 'package:proyek_awal/domain/usecases/tv/get_now_playing_tv.dart';
import 'package:proyek_awal/common/state_enum.dart';
import 'package:proyek_awal/domain/usecases/tv/get_popular_tv.dart';
import 'package:proyek_awal/domain/usecases/tv/get_top_rated_tv.dart';
import 'package:flutter/material.dart';

class TvListNotifier extends ChangeNotifier {
  var _nowPlayingTv = <Tv>[];
  List<Tv> get nowPlayingTv => _nowPlayingTv;

  RequestState _nowPlayingState = RequestState.Empty;
  RequestState get nowPlayingState => _nowPlayingState;

  var _popularTv = <Tv>[];
  List<Tv> get popularTv => _popularTv;

  RequestState _popularTvState = RequestState.Empty;
  RequestState get popularTvState => _popularTvState;

  var _topRatedTv = <Tv>[];
  List<Tv> get topRatedTv => _topRatedTv;

  RequestState _topRatedTvState = RequestState.Empty;
  RequestState get topRatedMoviesState => _topRatedTvState;

  String _message = '';
  String get message => _message;

  TvListNotifier({
    required this.getNowPlayingTv,
    required this.getPopularTv,
    required this.getTopRatedTv,
  });

  final GetNowPlayingTv getNowPlayingTv;
  final GetPopularTv getPopularTv;
  final GetTopRatedTv getTopRatedTv;

  Future<void> fetchNowPlayingTv() async {
    _nowPlayingState = RequestState.Loading;
    notifyListeners();

    final result = await getNowPlayingTv.execute();
    result.fold(
      (failure) {
        _nowPlayingState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (moviesData) {
        _nowPlayingState = RequestState.Loaded;
        _nowPlayingTv = moviesData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchPopularTv() async {
    _popularTvState = RequestState.Loading;
    notifyListeners();

    final result = await getPopularTv.execute();
    result.fold(
      (failure) {
        _popularTvState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (moviesData) {
        _popularTvState = RequestState.Loaded;
        _popularTv = moviesData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopRatedTv() async {
    _topRatedTvState = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedTv.execute();
    result.fold(
      (failure) {
        _topRatedTvState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (moviesData) {
        _topRatedTvState = RequestState.Loaded;
        _topRatedTv = moviesData;
        notifyListeners();
      },
    );
  }
}