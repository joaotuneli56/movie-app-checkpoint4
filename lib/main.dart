import 'dart:io';
import 'package:flutter/material.dart';
import 'package:movie_app/common/myhttp.dart';
import 'package:movie_app/common/utils.dart';
import 'package:movie_app/pages/home/home_page.dart';
import 'package:movie_app/pages/my_list/my_list_page.dart';  
import 'package:movie_app/pages/search/search_page.dart'; 
import 'package:movie_app/pages/top_rated/top_rated_page.dart'; 
import 'package:movie_app/pages/movie_detail/movie_detail_page.dart'; 
import 'package:movie_app/widgets/bottom_nav_bar.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true).copyWith(
        scaffoldBackgroundColor: kBackgoundColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: kBackgoundColor,
          elevation: 0,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: kBackgoundColor,
        ),
      ),
      // Definindo as rotas do app
      initialRoute: '/',
      routes: {
        '/': (context) => BottomNavBar(), 
        '/home': (context) => HomePage(), 
        '/search': (context) => SearchPage(),  
        '/topRated': (context) => TopRatedPage(),  
        '/movieDetail': (context) => MovieDetailPage(),
        '/my_list': (context) => WatchlistPage(),
      },
    );
  }
}
