import 'package:daily_meals/models/recipes.dart';

const List<String> diet = [
  "balanced",
  "high-fiber",
  "high-protein",
  "low-carb",
  "low-fat",
  "low-sodium"
];

const List<String> cuisineType = [
  "american",
  "asian",
  "british",
  "caribbean",
  "central europe",
  "chinese",
  "eastern europe",
  "french",
  "greek",
  "indian",
  "italian",
  "japanese",
  "korean",
  "kosher",
  "mediterranean",
  "mexican",
  "middle eastern",
  "nordic",
  "south american",
  "south east asian",
  "world"
];

const mealType = ["breakfast", "dinner", "lunch", "snack", "teatime"];

const Map<FiltersENUM, List<String>> allFiltersData = {
  FiltersENUM.diet: diet,
  FiltersENUM.cuisineType: cuisineType,
};
