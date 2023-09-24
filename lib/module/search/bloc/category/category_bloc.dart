import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';

import '../../model/category_model.dart';
import '../../repo/category_fetch_repo.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepo repo;
  CategoryBloc(this.repo) : super(CategoryInitialState()) {
    on<CategoryFetchEvent>(onCategoryFetchEvent);
  }

  Future<FutureOr<void>> onCategoryFetchEvent(
      CategoryFetchEvent event, Emitter<CategoryState> emit) async {
    List<CategoryModel> categories = [];
    emit(CategoryInitialState());
    try {
      var res = await repo.fetchCategory();
      var restData = jsonDecode(res);
      List<dynamic> data = restData['data'];

      for (var item in data) {
        CategoryModel category = CategoryModel.fromJson(item);
        categories.add(category);
      }
      emit(CategoryFetchedState(categories: categories));
    } catch (e) {
      emit(CategoryErrorState());
    }
  }
}
