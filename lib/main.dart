import 'package:bus_reservation_front_end/pages/add_bus_page.dart';
import 'package:bus_reservation_front_end/pages/add_route_page.dart';
import 'package:bus_reservation_front_end/pages/add_schedule_page.dart';
import 'package:bus_reservation_front_end/pages/booking_confirmation_page.dart';
import 'package:bus_reservation_front_end/pages/login_page.dart';
import 'package:bus_reservation_front_end/pages/reservation_page.dart';
import 'package:bus_reservation_front_end/pages/search_page.dart';
import 'package:bus_reservation_front_end/pages/search_result_page.dart';
import 'package:bus_reservation_front_end/pages/seat_plan_page.dart';
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
      //home: const SearchPage(),
      initialRoute: routeNameHome,
      routes: {
        routeNameHome: (context) => const SearchPage(),
        routeNameSearchResultPage: (context) => const SearchResultPage(),
        routeNameSeatPlanPage: (context) => const SeatPlanPage(),
        routeNameBookingConfirmationPage: (context) =>
            const BookingConfirmationPage(),
        routeNameAddBusPage: (context) => const AddBusPage(),
        routeNameAddRoutePage: (context) => const AddRoutePage(),
        routeNameAddSchedulePage: (context) => const AddSchedulePage(),
        routeNameReservationPage: (context) => const ReservationPage(),
        routeNameLoginPage: (context) => const LoginPage(),
      },
    );
  }
}
