import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smaperpus/providers/comic_provider.dart';
import 'package:smaperpus/screens/home/home_page.dart';
import 'package:smaperpus/screens/pages/book_details.dart';
import 'package:smaperpus/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ComicProvider(), // Provide ComicProvider here
      child: MaterialApp(
        title: "SMAPERPUS",
        theme: ThemeData(
          // Tema default (mode terang)
          // Properti lainnya
        ),
        darkTheme: ThemeData(
          // Tema gelap
          brightness: Brightness.dark,
          // Properti lainnya
        ),
        themeMode: ThemeMode.dark,
        debugShowCheckedModeBanner: false,
        initialRoute: SplashScreen.nameRoute,
        routes: {
          SplashScreen.nameRoute: (context) => SplashScreen(),
          HomePage.nameRoute: (context) => HomePage(),
          BookDetail.nameRoute: (context) => BookDetail(),
        },
      ),
    );
  }
}
