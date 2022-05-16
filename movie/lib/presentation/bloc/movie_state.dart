import 'package:core/domain/entities/movie/movie.dart';
import 'package:equatable/equatable.dart';

abstract class MovieState extends Equatable {
  const MovieState();

  @override
  List<Object> get props => [];
}

class MovieEmpty extends MovieState {}

class MovieLoading extends MovieState {}

class MovieError extends MovieState {
  final String message;

  const MovieError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieLoaded extends MovieState {
  final List<Movie> result;

  const MovieLoaded(this.result);

  @override
  List<Object> get props => [result];
}
