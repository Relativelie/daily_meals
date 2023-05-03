import 'package:flutter/material.dart';

import 'package:daily_meals/models/navigation.dart';
import 'package:daily_meals/screens/favorites/favorites.dart';
import 'package:daily_meals/screens/home/home.dart';
import 'package:daily_meals/screens/meal_categories/meal_categories.dart';
import 'package:daily_meals/screens/profile/profile.dart';
import 'package:daily_meals/screens/recipes/recipes.dart';

class WdTabNavigator extends StatelessWidget {
  const WdTabNavigator(
      {super.key, required this.navigatorKey, required this.tabItem});
  final GlobalKey<NavigatorState> navigatorKey;
  final TabsENUM tabItem;

  void _push(BuildContext context, {Object? args}) {
    var routeBuilders = _routeBuilders(context);

    Navigator.push(
        context,
        MaterialPageRoute(
            settings: RouteSettings(arguments: args),
            builder: (context) =>
                routeBuilders[RoutesENUM.recipes.name]!(context)));
  }

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context) {
    return {
      RoutesENUM.home.name: (BuildContext context) => const HomeScreen(),
      RoutesENUM.categories.name: (BuildContext context) =>
          MealCategoriesScreen(
              onPush: (Object? args) => _push(context, args: args)),
      RoutesENUM.recipes.name: (BuildContext context) => const RecipesScreen(),
      RoutesENUM.favorite.name: (BuildContext context) =>
          const FavoriteScreen(),
      RoutesENUM.profile.name: (BuildContext context) => const ProfileScreen(),
    };
  }

  @override
  Widget build(BuildContext context) {
    var routeBuilders = _routeBuilders(context);

    return Navigator(
        key: navigatorKey,
        initialRoute: tabItem.name,
        onGenerateRoute: (routeSettings) {
          return MaterialPageRoute(
              builder: (context) =>
                  routeBuilders[routeSettings.name]!(context));
        });
  }
}
