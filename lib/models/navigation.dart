import 'package:flutter/material.dart';

enum TabsENUM {
  home,
  categories,
  favorite,
  profile,
}

enum RoutesENUM {
  home,
  categories,
  favorite,
  profile,
  recipes,
}

class TabScreen {
  const TabScreen({required this.screen, required this.icon});

  final Widget screen;
  final IconData icon;
}
