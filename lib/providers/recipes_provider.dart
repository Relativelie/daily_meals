import 'package:daily_meals/data/recipes_data.dart';
import 'package:daily_meals/models/categories.dart';
import 'package:daily_meals/models/recipes.dart';
import 'package:daily_meals/services/recipes_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Map<String, bool> _generateFilter(List<String> filterList) {
  Map<String, bool> generatedFilter = {};
  filterList.asMap().forEach((index, e) {
    generatedFilter[e] = false;
  });
  return {...generatedFilter};
}

class RecipeNotifier extends StateNotifier<Recipes> {
  RecipeNotifier() : super(Recipes(recipes: [], filters: {}));

  void onChangeFilters(value) {
    final newFilters = {...state.filters};
    value.forEach((k, v) => newFilters[k] = Map.from(v));
    state = Recipes(
        recipes: state.recipes,
        nextPage: state.nextPage,
        filters: {...newFilters});
  }

  void initFilters(MealTypeENUM val) {
    final filters = {
      for (var v in FiltersENUM.values) v: _generateFilter(allFiltersData[v]!)
    };
    state = Recipes(
        recipes: state.recipes,
        filters: filters,
        nextPage: state.nextPage,
        selectedCategory: val.name);
  }

  Future<void> loadRecipes({
    required String searchingValue,
  }) async {
    final recipeService = RecipeService();
    final res = await recipeService.loadRecipes(
        searchingValue: searchingValue,
        filters: state.filters,
        selectedCategory: state.selectedCategory);

    state = Recipes(
      recipes: res?["recipes"] as List<Recipe>,
      nextPage: res?["nextPage"] as String?,
      filters: state.filters,
    );
  }

  Future<void> loadNextRecipes() async {
    final recipeService = RecipeService();
    final res = await recipeService.loadNextRecipes(state.nextPage!);
    state = Recipes(
      recipes: res?["recipes"] as List<Recipe>,
      nextPage: res?["nextPage"] as String?,
      filters: state.filters,
    );
  }
}

class Recipes {
  List<Recipe> recipes;
  Map<FiltersENUM, Map<String, bool>> filters;
  String? selectedCategory;
  String? nextPage;

  Recipes(
      {required this.recipes,
      required this.filters,
      this.selectedCategory,
      this.nextPage});
}

final recipesProvider = StateNotifierProvider<RecipeNotifier, Recipes>((ref) {
  return RecipeNotifier();
});
