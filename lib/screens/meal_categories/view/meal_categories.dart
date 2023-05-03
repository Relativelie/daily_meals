import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:daily_meals/data/categories_data.dart';
import 'package:daily_meals/models/categories.dart';
import 'package:daily_meals/models/recipes.dart';
import 'package:daily_meals/providers/recipes_provider.dart';
import 'package:daily_meals/screens/meal_categories/widgets/widgets.dart';

class MealCategoriesScreen extends ConsumerStatefulWidget {
  const MealCategoriesScreen({required this.onPush, super.key});
  final void Function(Object? args) onPush;

  @override
  ConsumerState<MealCategoriesScreen> createState() {
    return _MealCategoriesScreenState();
  }
}

class _MealCategoriesScreenState extends ConsumerState<MealCategoriesScreen> {
  void onSelectMeal(BuildContext context, MealTypeENUM selectedCategory) {
    ref.read(recipesProvider.notifier).initFilters(selectedCategory);
    widget.onPush(RecipesScreenArgs(selectedCategory));
  }

  @override
  Widget build(BuildContext context) {
    final recipesState = ref.watch(recipesProvider);

    return Scaffold(
        body: ListView(
      physics: const ClampingScrollPhysics(),
      children: mealCategories
          .map(
            (category) => Padding(
              padding: const EdgeInsets.all(10.0),
              child: WdMealCard(
                title: category.title,
                mealImg: category.img,
                onPressed: () => onSelectMeal(context, category.value),
              ),
            ),
          )
          .toList(),
    ));
  }
}
