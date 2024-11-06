import 'package:flutter/material.dart';
import 'package:online_ticket_booking/models/bus_model.dart';
import 'package:online_ticket_booking/pages/buyTickets/seatSelection/select_seat_screen.dart';

import '../utils/styles.dart';

class BusWidget extends StatelessWidget {
  const BusWidget({
    super.key,
    required this.bus,
  });

  final Bus bus;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.all(10.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SelectSeatsScreen(bus: bus),
              ));
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Image.asset(
                'assets/bus.png', // Replace with your asset image path
                height: 50,
                // width: 50,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Bus #: ${bus.busNumber}', style: TextStyles.bold16),
                    const SizedBox(height: 5),
                    Text(
                      '${bus.departure} to ${bus.arrival}',
                      style: TextStyles.normalW500,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      // 'Departure: ${DateFormat('yyyy-MM-dd – kk:mm').format(bus.departureTime)}',
                      'Departure Date: ${bus.departureDate}',
                      style: TextStyles.normalW500,
                    ),
                    const SizedBox(height: 5),
                    // Text('Date: ${DateFormat('yyyy-MM-dd').format(bus.departureTime)}', style: TextStyles.normalW500),
                    Text('Departure Time: ${bus.departureTime}', style: TextStyles.normalW500),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
