class Booking {
  final String bookingID;
  final String userID;
  final String busId;
  final String agencyName;
  final String seatNumber;
  final String passengerName;
  final String passengerPhone;
  final String passengerNIC;
  final String passengerGender;
  final String from;
  final String to;
  final String status;
  final DateTime bookingTime;
  final String departureDate;
  final String departureTime;

  Booking({
    required this.bookingID,
    required this.userID,
    required this.busId,
    required this.agencyName,
    required this.seatNumber,
    required this.passengerName,
    required this.passengerPhone,
    required this.passengerNIC,
    required this.passengerGender,
    required this.from,
    required this.to,
    required this.status,
    required this.bookingTime,
    required this.departureDate,
    required this.departureTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'userID': userID,
      'busID': busId,
      'seatNumber': seatNumber,
      'agencyName': agencyName,
      'passengerName': passengerName,
      'passengerPhone': passengerPhone,
      'passengerNIC': passengerNIC,
      'passengerGender': passengerGender,
      'departure': from,
      'arrival': to,
      'status': status,
      'bookingTime': bookingTime.toIso8601String(),
      'departureDate': departureDate,
      'departureTime': departureTime,
    };
  }

  factory Booking.fromMap(Map<String, dynamic> map, String docID) {
    return Booking(
      bookingID: docID,
      userID: map['userID'],
      busId: map['busID'],
      agencyName: map['agencyName'],
      seatNumber: map['seatNumber'],
      passengerName: map['passengerName'],
      passengerPhone: map['passengerPhone'],
      passengerNIC: map['passengerNIC'],
      passengerGender: map['passengerGender'],
      from: map['departure'],
      to: map['arrival'],
      status: map['status'],
      bookingTime: DateTime.parse(map['bookingTime']),
      departureDate: map['departureDate'],
      departureTime: map['departureTime'],
    );
  }
}
