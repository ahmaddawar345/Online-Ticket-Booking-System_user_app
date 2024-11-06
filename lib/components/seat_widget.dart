import 'package:flutter/material.dart';

class SeatWidget extends StatelessWidget {
  final int seatNumber;
  final VoidCallback onTap;
  final bool isReserved;
  const SeatWidget({
    super.key,
    required this.seatNumber,
    required this.onTap,
    required this.isReserved,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 40,
      icon: Image.asset(
        'assets/${isReserved ? 'reservedSeat' : 'availableSeat'}.png', // Change image based on reservation status
      ),
      onPressed: onTap,
    );
    // IconButton(
    // iconSize: 40,
    // icon: Image(
    //   image: AssetImage('assets/${seatNumber.toString()}seat.png'), // Placeholder for seat images
    // ),
    // onPressed: onTap,
    // );
  }
}
