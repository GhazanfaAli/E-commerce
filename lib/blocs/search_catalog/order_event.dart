// order_event.dart
part of 'order_bloc.dart';

@immutable
abstract class OrderEvent {}

class SearchProducts extends OrderEvent {
  final String query;
  final int count;

  SearchProducts(this.query, this.count);
}
class SelectCategory extends OrderEvent {
  final String category;
  SelectCategory(this.category);
}
