import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:daily_meals/providers/darkMode_provider.dart';
import 'package:daily_meals/screens/app/app.dart';
import 'package:daily_meals/config/theme/theme.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isDarkMode = ref.watch(darkModeProvider);

    return MaterialApp(
      title: 'Recipes',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: const AppScreen(),
    );
  }
}
