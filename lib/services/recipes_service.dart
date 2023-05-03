import 'package:daily_meals/models/categories.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:daily_meals/utils/show_toast.dart';
import 'package:daily_meals/models/recipes.dart';
import 'package:daily_meals/services/methods.dart';
import 'package:daily_meals/services/network_error.dart';

class RecipeService {
  final Methods _methods = Methods();

  final _edamamQueryParams = {
    "app_key": dotenv.env['API_RECIPES_KEY'],
    "app_id": dotenv.env['API_RECIPES_ID'],
    "type": "public",
  };

  final String _url = dotenv.env["BASE_RECIPES_URL"]!;

  List<String> _parseFilterForQuery(FiltersENUM key,
      {Map<FiltersENUM, Map<String, bool>>? filters}) {
    final checkedFilterValues = {...?filters?[key]}
        .entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();
    return checkedFilterValues;
  }

  Future<Map<String, Object?>?> _getRecipes(queryParameters) async {
    try {
      final res = await _methods.get(_url, params: queryParameters);
      final recipesData = res["hits"];
      String? nextPage;
      List<Recipe> recipes = [];
      if (recipesData.length != 0) {
        recipes = recipesData
            .map<Recipe>((item) => Recipe.fromJson(item["recipe"]))
            .toList();
        nextPage = res["_links"]["next"]?["href"];
      }
      return {"recipes": recipes, "nextPage": nextPage};
    } on HttpException catch (e) {
      showToast(e.errors.toString());
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<Map<String, Object?>?> loadRecipes({
    required String searchingValue,
    Map<FiltersENUM, Map<String, bool>>? filters,
    String? selectedCategory
  }) async {
    final parsedFilters = {
      SearchingQueryENUM.q.name: searchingValue,
      for (var v in FiltersENUM.values) v.name: _parseFilterForQuery(v, filters: filters),
      MealQueryENUM.mealType.name: selectedCategory != MealTypeENUM.all.name ? selectedCategory : []
    };
    return await _getRecipes({..._edamamQueryParams, ...parsedFilters});
  }

  Future<Map<String, Object?>?> loadNextRecipes(String nextPage) async {
    final queryParameters = Uri.parse(nextPage).queryParametersAll;
    return await _getRecipes(queryParameters);
  }
}
