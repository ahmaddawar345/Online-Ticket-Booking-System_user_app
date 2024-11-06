// // TODO Implement this library.
// import 'package:flutter/material.dart';
// import 'package:online_ticket_booking/utils/styles.dart';
//
// import '../components/booking_tile.dart';
// import 'home_screen.dart';
//
// ///
//
// class MyBookings extends StatefulWidget {
//   static const String id = 'mybookings';
//   const MyBookings({super.key});
//
//   @override
//   State<MyBookings> createState() => _MyBookingsState();
// }
//
// class _MyBookingsState extends State<MyBookings> {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//       appBar: AppBar(
//         leading: BackButton(
//           onPressed: () {
//             Navigator.pushNamed(context, HomeScreen.id);
//           },
//         ),
//         backgroundColor: const Color(0XFF30D15D),
//         title: const Center(child: Text('My Bookings')),
//       ),
//       body: Container(
//         constraints: const BoxConstraints.expand(),
//         decoration: BoxDecoration(
//           gradient: gradientGreen,
//         ),
//         child: Padding(
//           padding: EdgeInsets.all(20.0),
//           child: StreamBuilder(
//             stream: ,
//
//             builder: (context, snapshot)  {
//               return BookingTile();
//
//             }
//           ),
//         ),
//       ),
//     ));
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:online_ticket_booking/utils/constants.dart';
import 'package:online_ticket_booking/utils/styles.dart';

import '../components/booking_tile.dart';
import '../models/booking_model.dart';
import 'home_screen.dart';

class MyBookings extends StatefulWidget {
  static const String id = 'mybookings';
  const MyBookings({super.key});

  @override
  State<MyBookings> createState() => _MyBookingsState();
}

class _MyBookingsState extends State<MyBookings> {
  Stream<List<Booking>> _getBookingsStream() {
    return FirebaseFirestore.instance
        .collection(bookingsCollection)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => Booking.fromMap(doc.data(), doc.id)).toList());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () {
              Navigator.pushNamed(context, HomeScreen.id);
            },
          ),
          backgroundColor: const Color(0XFF30D15D),
          title: const Center(child: Text('My Bookings')),
        ),
        body: Container(
          constraints: const BoxConstraints.expand(),
          decoration: BoxDecoration(
            gradient: gradientGreen,
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: StreamBuilder<List<Booking>>(
              stream: _getBookingsStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No bookings available.'));
                }

                final bookings = snapshot.data!;
                return ListView.builder(
                  itemCount: bookings.length,
                  itemBuilder: (context, index) {
                    final booking = bookings[index];
                    return BookingTile(booking: booking);
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
