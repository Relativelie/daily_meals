import 'package:daily_meals/models/recipes.dart';
import 'package:daily_meals/providers/recipes_provider.dart';
import 'package:daily_meals/screens/recipes/widgets/widgets.dart';
import 'package:daily_meals/utils/to_capitalize.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class RecipesScreen extends ConsumerStatefulWidget {
  const RecipesScreen({super.key});


  @override
  ConsumerState<RecipesScreen> createState() {
    return _RecipesScreenState();
  }
}

class _RecipesScreenState extends ConsumerState<RecipesScreen> {
  final PagingController<String?, Recipe> _pagingController =
      PagingController(firstPageKey: null);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage();
    });
    super.initState();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  Future<void> _fetchPage() async {
    bool isFirstPage = ref.read(recipesProvider).nextPage == null;
    if (isFirstPage) {
      _loadFirstPage();
    } else {
      _loadNextPage();
    }
  }

  Future<void> _loadFirstPage() async {
    await ref.read(recipesProvider.notifier).loadRecipes(searchingValue: "");
    _appendPaginatedList(
        ref.read(recipesProvider).recipes, ref.read(recipesProvider).nextPage);
  }

  Future<void> _loadNextPage() async {
    await ref.read(recipesProvider.notifier).loadNextRecipes();
    _appendPaginatedList(
        ref.read(recipesProvider).recipes, ref.read(recipesProvider).nextPage);
  }

  void _appendPaginatedList(List<Recipe> recipes, String? nextPage) {
    bool isLastPage = nextPage == null;
    if (isLastPage) {
      _pagingController.appendLastPage(recipes);
    } else {
      _pagingController.appendPage(recipes, nextPage);
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as RecipesScreenArgs;

    return Scaffold(
      appBar: AppBar(
        title: Text(toCapitalize(args.selectedMeal.name)),
      ),
      body: RefreshIndicator(
          onRefresh: () => Future.sync(
                () => _pagingController.refresh(),
              ),
          child: PagedListView<String?, Recipe>(
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate<Recipe>(
                itemBuilder: (context, item, index) => WdRecipeCard(
                      title: item.label,
                      ingredients: item.ingredientLines.length,
                      cuisineLabels: item.cuisineType,
                      dietLabels: item.dietLabels,
                      image: item.image,
                    )),
          )),

      // Text(ref.watch(recipesProvider).recipes.isNotEmpty
      //     ? ref.watch(recipesProvider).recipes[0].label
      //     : "dv"),
    );
  }
}
