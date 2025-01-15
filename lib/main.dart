import 'package:flutter/material.dart';
import 'package:news_app/ui/category_screen/category_screen.dart';
import 'package:news_app/ui/home_screen/home_screen.dart';
import 'package:news_app/utils/app_theme.dart';

void main() {
  runApp(const NewsApp());
}

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: CategoryScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => const HomeScreen(),
        CategoryScreen.routeName: (context) => const CategoryScreen(),
      },
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
    );
  }
}
