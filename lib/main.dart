import 'package:flutter/material.dart';
import 'package:news_app/providers/theme_provider.dart';
import 'package:news_app/ui/home_screen/home_screen.dart';
import 'package:news_app/utils/app_theme.dart';
import 'package:news_app/utils/helpers/cash_helper.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await CashHelper.init();
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider(),),
      ],
      child: const NewsApp()));
}

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider= Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => const HomeScreen(),
      },
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode:themeProvider.appTheme,
    );
  }
}
