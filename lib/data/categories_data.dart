

import 'package:daily_meals/models/categories.dart';

const mealCategories = [
  Category(
      title: "Breakfast", img: "assets/jpeg/breakfast.jpg", value: MealTypeENUM.breakfast),
  Category(title: "Dinner", img: "assets/jpeg/dinner.jpg", value: MealTypeENUM.dinner),
  Category(title: "Lunch", img: "assets/jpeg/lunch.jpg", value: MealTypeENUM.lunch),
  Category(title: "Snack", img: "assets/jpeg/snack.jpg", value: MealTypeENUM.snack),
  Category(title: "Teatime", img: "assets/jpeg/teatime.jpg", value: MealTypeENUM.snack),
    Category(title: "All", img: "assets/jpeg/all_meals.jpg", value: MealTypeENUM.all),
];

class Category {
  const Category({
    required this.title,
    required this.img,
    required this.value,
  });
  final String title;
  final String img;
  final MealTypeENUM value;
}