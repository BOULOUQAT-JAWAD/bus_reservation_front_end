import 'package:bus_reservation_front_end/datasource/data_source.dart';
import 'package:bus_reservation_front_end/datasource/dummy_data_source.dart';
import 'package:bus_reservation_front_end/models/bus_route.dart';
import 'package:flutter/material.dart';

class AppDataProvider extends ChangeNotifier {
  final DataSource _dataSource = DummyDataSource();
  Future<BusRoute?> getRouteByCityFromAndCityTo(
      String cityFrom, String cityTo) {
    return _dataSource.getRouteByCityFromAndCityTo(cityFrom, cityTo);
  }
}
