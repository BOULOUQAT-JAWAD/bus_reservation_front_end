import 'package:bus_reservation_front_end/models/bus_schedule.dart';
import 'package:bus_reservation_front_end/models/customer.dart';

class BusReservation {
  int? reservationId;
  Customer customer;
  BusSchedule busSchedule;
  int timestamp;
  String departureDate;
  int totalSeatBooked;
  String seatNumbers;
  String reservationStatus;
  int totalPrice;

  BusReservation({
    this.reservationId,
    required this.customer,
    required this.busSchedule,
    required this.timestamp,
    required this.departureDate,
    required this.totalSeatBooked,
    required this.seatNumbers,
    required this.reservationStatus,
    required this.totalPrice,
  });
}
