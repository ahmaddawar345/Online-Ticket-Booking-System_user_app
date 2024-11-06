import 'package:intl/intl.dart';

class RefundStatus {
  final String id;
  final String refundReason;
  final String bookingId;
  final String status;
  final String date;
  final String time;

  RefundStatus({
    required this.id,
    required this.refundReason,
    required this.bookingId,
    required this.status,
  })  : date = DateFormat('yyyy-MM-dd').format(DateTime.now()),
        time = DateFormat('HH:mm:ss').format(DateTime.now());

  // Convert from Map
  factory RefundStatus.fromMap(Map<String, dynamic> map, String id) {
    return RefundStatus(
      id: id,
      refundReason: map['refundReason'],
      bookingId: map['bookingId'],
      status: map['status'],
    );
  }

  // Convert to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'refundReason': refundReason,
      'bookingId': bookingId,
      'status': status,
      'date': date,
      'time': time,
    };
  }
}
