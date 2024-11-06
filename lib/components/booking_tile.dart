import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/booking_model.dart';

class BookingTile extends StatefulWidget {
  final Booking booking;

  const BookingTile({
    super.key,
    required this.booking,
  });

  @override
  State<BookingTile> createState() => _BookingTileState();
}

class _BookingTileState extends State<BookingTile> {
  // String? agencyName;
  @override
  void initState() {
    // findAgency();
    super.initState();
  }

  // findAgency() async {
  //   agencyName = widget.booking.agencyName;
  //   DocumentSnapshot data = await fireStore.collection(agenciesCollection).doc(agencyId).get();
  //   print(data.id);
  // }

  @override
  Widget build(BuildContext context) {
    Color getStatusColor() {
      switch (widget.booking.status.toLowerCase()) {
        case 'approved':
          return Colors.green;
        case 'rejected':
          return Colors.red;
        default:
          return Colors.orange;
      }
    }

    IconData getStatusIcon() {
      switch (widget.booking.status.toLowerCase()) {
        case 'approved':
          return Icons.check_circle_outline;
        case 'rejected':
          return Icons.cancel_outlined;
        default:
          return Icons.hourglass_empty;
      }
    }

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      shadowColor: Colors.black26,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.booking.agencyName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 5),
            Divider(color: Colors.grey.shade300),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.location_on, color: Colors.blue),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'From: ${widget.booking.from}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.arrow_forward, color: Colors.blue),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'To: ${widget.booking.to}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.date_range, color: Colors.blue),
                const SizedBox(width: 8),
                Text(
                  'Date: ${widget.booking.departureDate}',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.access_time, color: Colors.blue),
                const SizedBox(width: 8),
                Text(
                  'Time: ${widget.booking.departureTime}',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'Seat: ${widget.booking.seatNumber}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 5),
            Text(
              'Bus no :   ${widget.booking.busId}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                SelectableText(
                  'Booking ID :   ${widget.booking.bookingID}',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                IconButton(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: widget.booking.bookingID));
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                          const SnackBar(content: Text('Booking ID copied to clipboard')),
                        );
                    },
                    icon: const Icon(Icons.copy))
              ],
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  getStatusIcon(),
                  color: getStatusColor(),
                ),
                const SizedBox(width: 8),
                Text(
                  'Status: ${widget.booking.status}',
                  style: TextStyle(
                    color: getStatusColor(),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
