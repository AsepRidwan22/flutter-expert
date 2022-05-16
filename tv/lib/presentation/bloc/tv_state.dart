import 'package:core/domain/entities/tv/tv.dart';
import 'package:equatable/equatable.dart';

abstract class TvState extends Equatable {
  const TvState();

  @override
  List<Object> get props => [];
}

class TvEmpty extends TvState {}

class TvLoading extends TvState {}

class TvError extends TvState {
  final String message;

  const TvError(this.message);

  @override
  List<Object> get props => [message];
}

class TvLoaded extends TvState {
  final List<Tv> result;

  const TvLoaded(this.result);

  @override
  List<Object> get props => [result];
}
