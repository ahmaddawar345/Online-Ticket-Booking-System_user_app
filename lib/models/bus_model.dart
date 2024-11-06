// class Bus {
//   final String busNumber;
//   final String departure;
//   final String arrival;
//   final DateTime departureTime;
//   final String busName;
//
//   Bus({
//     required this.busNumber,
//     required this.departure,
//     required this.arrival,
//     required this.departureTime,
//     required this.busName,
//   });
// }

import 'package:online_ticket_booking/models/seat_model.dart';

class Bus {
  final String busId;
  final String agencyId;
  final String busNumber;
  final int capacity;
  final String departure;
  final String arrival;
  final String departureDate;
  final String departureTime;
  final Map<String, Seat> reservedSeats;

  Bus({
    required this.busId,
    required this.agencyId,
    required this.busNumber,
    required this.capacity,
    required this.departure,
    required this.arrival,
    required this.departureDate,
    required this.departureTime,
    required this.reservedSeats,
  });

  factory Bus.fromMap(Map<String, dynamic> data, String docId) {
    return Bus(
      busId: docId,
      busNumber: data['busNumber'],
      agencyId: data['agencyID'],
      capacity: data["capacity"],
      departure: data['departure'],
      arrival: data['arrival'],
      departureDate: data['departureDate'],
      departureTime: data['departureTime'],
      reservedSeats: (data['reservedSeats'] as Map<String, dynamic>).map(
        (key, value) => MapEntry(key, Seat.fromJson(value)),
      ),
    );
  }

  // factory DUMMY_BusModel.fromJson(Map<String, dynamic> json) {
  //   return DUMMY_BusModel(
  //     busId: json['busId'],
  //     agencyId: json['agencyId'],
  //     busNumber: json['busNumber'],
  //     capacity: json['capacity'],
  //     departure: json['departure'],
  //     arrival: json['arrival'],
  //     departureDate: json['departureDate'],
  //     departureTime: json['departureTime'],
  //     reservedSeats: (json['reservedSeats'] as Map<String, dynamic>).map(
  //           (key, value) => MapEntry(key, Seat.fromJson(value)),
  //     ),    );
  // }

  Map<String, dynamic> toJson(String docId) {
    return {
      'busId': busId,
      'agencyID': agencyId,
      'busNumber': busNumber,
      'capacity': capacity,
      'departure': departure,
      'arrival': arrival,
      'departureDate': departureDate,
      'departureTime': departureTime,
      'reservedSeats': reservedSeats.map((key, seat) => MapEntry(key, seat.toJson())),
    };
  }
}
