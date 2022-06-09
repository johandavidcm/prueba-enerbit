import 'package:flutter/material.dart';
import 'ui/pages/detail/detail_page.dart';
import 'ui/pages/home/home_page.dart';
import 'ui/theme/custom_theme.dart';

class RickAndMortyApp extends StatelessWidget {
  const RickAndMortyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prueba Enerbit',
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (context) => const HomePage(),
        DetailPage.routeName: (context) => const DetailPage(),
      },
      theme: CustomTheme.lightTheme,
    );
  }
}
