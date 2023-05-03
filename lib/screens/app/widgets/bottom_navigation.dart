import 'package:flutter/material.dart';

import 'package:daily_meals/models/navigation.dart';

const tabScreens = {
  TabsENUM.home: Icons.home,
  TabsENUM.categories: Icons.fastfood_rounded,
  TabsENUM.favorite: Icons.favorite,
  TabsENUM.profile: Icons.account_circle_sharp,
};

class WdBottomNavigation extends StatelessWidget {
  final TabsENUM currentTab;
  final void Function(int) onSelectTab;

  const WdBottomNavigation(
      {required this.currentTab, required this.onSelectTab, super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: onSelectTab,
      currentIndex: currentTab.index,
      items: tabScreens.keys
          .map(
            (key) => BottomNavigationBarItem(
              icon: Icon(tabScreens[key]),
              label: key.name,
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
          )
          .toList(),
      selectedItemColor: Theme.of(context).primaryColor,
      showUnselectedLabels: false,
    );
  }
}
