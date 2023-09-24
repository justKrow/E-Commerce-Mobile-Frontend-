part of 'category_bloc.dart';

abstract class CategoryState {}

class CategoryInitialState extends CategoryState {}

class CategoryFetchedState extends CategoryState {
  final List<CategoryModel> categories;

  CategoryFetchedState({required this.categories});
}

class CategoryErrorState extends CategoryState {}
