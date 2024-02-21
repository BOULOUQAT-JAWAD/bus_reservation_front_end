import 'package:bus_reservation_front_end/pages/search_page.dart';
import 'package:bus_reservation_front_end/pages/search_result_page.dart';
import 'package:bus_reservation_front_end/providers/app_data_provider.dart';
import 'package:bus_reservation_front_end/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => AppDataProvider(), child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutte Demo',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
        brightness: Brightness.dark,
      ),
      home: const SearchPage(),
      routes: {
        routeNameHome: (context) => const SearchPage(),
        routeNameSearchResultPage: (context) => const SearchResultPage()
      },
    );
  }
}
