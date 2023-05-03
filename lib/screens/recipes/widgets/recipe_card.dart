import 'package:flutter/material.dart';

class WdRecipeCard extends StatelessWidget {
  final String title;
  final num ingredients;
  final List<String> cuisineLabels;
  final List<String> dietLabels;
  final String? image;

  const WdRecipeCard(
      {required this.title,
      required this.ingredients,
      required this.cuisineLabels,
      required this.dietLabels,
      this.image,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).colorScheme.background,
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container(
                  height: 120.0,
                  width: 120.0,
                  decoration:  BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(120)),
                    color:  Theme.of(context).highlightColor,
                    image: DecorationImage(
                        image: NetworkImage(
                            image?.replaceAll("https", "http") ?? ""),
                        fit: BoxFit.cover,
                        alignment: Alignment.bottomCenter),
                  ),
                ),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleSmall,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
            Column(
              children: [
                Wrap(spacing: 5.0, alignment: WrapAlignment.center, children: [
                  ...cuisineLabels
                      .take(2)
                      .map((cuisine) => Text('#$cuisine'))
                      .toList(),
                  ...dietLabels
                      .take(2)
                      .map((diet) => Text('#$diet',
                          style: Theme.of(context).textTheme.bodySmall))
                      .toList()
                ]),
                Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    margin: const EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      '${ingredients.toString()} ingredients',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                    )),
              ],
            ),
          ],
        ));
  }
}
