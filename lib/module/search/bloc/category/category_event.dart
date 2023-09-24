part of 'category_bloc.dart';

abstract class CategoryEvent {}

class CategoryFetchEvent extends CategoryEvent {}

class CategorySelectEvent extends CategoryEvent {
  final int id;

  CategorySelectEvent({required this.id});
}
