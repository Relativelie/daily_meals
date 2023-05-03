import 'package:flutter/material.dart';

import 'package:daily_meals/models/navigation.dart';
import 'package:daily_meals/screens/app/widgets/widgets.dart';


class AppScreen extends StatefulWidget {
  const AppScreen({super.key});

  @override
  State<AppScreen> createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  TabsENUM currentTab = TabsENUM.home;
  Map<TabsENUM, GlobalKey<NavigatorState>> navigatorKeys = {
    TabsENUM.home: GlobalKey<NavigatorState>(),
    TabsENUM.categories: GlobalKey<NavigatorState>(),
    TabsENUM.favorite: GlobalKey<NavigatorState>(),
    TabsENUM.profile: GlobalKey<NavigatorState>(),
  };

  void onSelectTab(int index) {
    setState(() {
      currentTab = TabsENUM.values[index];
    });
  }

  Widget _buildOffstageNavigator(TabsENUM tabItem) {
    return Offstage(
      offstage: currentTab != tabItem,
      child: WdTabNavigator(
        navigatorKey: navigatorKeys[tabItem]!,
        tabItem: tabItem,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // drawer: MainDrawer(
        //   onSelectScreen: _changeActiveScreen,
        // ),
        body: Stack(
          children: TabsENUM.values
              .map((item) => _buildOffstageNavigator(item))
              .toList(),
        ),
        bottomNavigationBar: WdBottomNavigation(
            currentTab: currentTab, onSelectTab: onSelectTab));
  }
}
