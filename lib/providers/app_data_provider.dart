import 'package:bus_reservation_front_end/datasource/data_source.dart';
import 'package:bus_reservation_front_end/datasource/dummy_data_source.dart';
import 'package:bus_reservation_front_end/models/bus_model.dart';
import 'package:bus_reservation_front_end/models/bus_reservation.dart';
import 'package:bus_reservation_front_end/models/bus_route.dart';
import 'package:bus_reservation_front_end/models/bus_schedule.dart';
import 'package:bus_reservation_front_end/models/response_model.dart';
import 'package:flutter/material.dart';

class AppDataProvider extends ChangeNotifier {
  List<Bus> _busList = [];

  List<BusRoute> _routeList = [];

  List<Bus> get busList => _busList;
  List<BusRoute> get routeList => _routeList;

  final DataSource _dataSource = DummyDataSource();

  Future<BusRoute?> getRouteByCityFromAndCityTo(
      String cityFrom, String cityTo) {
    return _dataSource.getRouteByCityFromAndCityTo(cityFrom, cityTo);
  }

  Future<List<BusSchedule>> getSchedulesByRouteName(String routeName) async {
    return _dataSource.getSchedulesByRouteName(routeName);
  }

  Future<List<BusReservation>> getReservationsByScheduleAndDepartureDate(
      int scheduleId, String departureDate) async {
    return _dataSource.getReservationsByScheduleAndDepartureDate(
        scheduleId, departureDate);
  }

  Future<ResponseModel> addBus(Bus bus) {
    return _dataSource.addBus(bus);
  }

  Future<ResponseModel> addRoute(BusRoute route) {
    return _dataSource.addRoute(route);
  }

  Future<ResponseModel> addSchedule(BusSchedule busSchedule) {
    return _dataSource.addSchedule(busSchedule);
  }

  Future<ResponseModel> addReservation(BusReservation reservation) {
    return _dataSource.addReservation(reservation);
  }

  void getAllBus() async {
    _busList = await _dataSource.getAllBus();
    notifyListeners();
  }

  void getAllBusRoutes() async {
    _routeList = await _dataSource.getAllRoutes();
    notifyListeners();
  }
}
