part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchedProduct extends HomeEvent {
  final String? categoryUrl;

  FetchedProduct({this.categoryUrl});
  @override
  List<Object?> get props => [categoryUrl];
}
