import 'package:flutter/material.dart';
import 'package:news_app/provider/newscategory_provider.dart';
import 'package:news_app/provider/theme_provider.dart';
import 'package:news_app/screen/homepage.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider<SliderProvider>(create: (_) => SliderProvider()),
        ChangeNotifierProvider(create: (_) => NewsCategoryProvider()),
        ChangeNotifierProvider(create: (_) => NewsProviderSec1()),

        // Add more providers as needed
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: themeProvider.themeMode,
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        // theme: ThemeData(
        //   primaryColor: Colors.red, // Use a predefined color
        //   // primaryColor: Color(0xFF6200EA), // Use a custom color (purple in this case)
        // ),
        home: HomePage(),
      ),
    );
  }
}
