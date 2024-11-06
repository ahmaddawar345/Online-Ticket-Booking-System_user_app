class Seat {
  final String seatNo;
  final bool reserved;
  final String gender;
  final String userId;

  Seat({
    required this.seatNo,
    required this.gender,
    required this.reserved,
    required this.userId,
  });

  factory Seat.fromJson(Map<String, dynamic> json) {
    return Seat(
      userId: json['userId'],
      gender: json['gender'],
      seatNo: json['seatNo'],
      reserved: json['reserved'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'seatNo': seatNo,
      'reserved': reserved,
      'userId': userId,
      'gender': gender,
    };
  }
}
