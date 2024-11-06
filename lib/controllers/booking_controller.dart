import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:online_ticket_booking/utils/constants.dart';

import '../models/booking_model.dart';

class BookingController extends ChangeNotifier {
  // Future<void> addBooking(Booking booking) async {
  //   // Generate a new document reference with an auto ID
  //   final bookingRef = FirebaseFirestore.instance.collection('bookings').doc();
  //   // Assign the auto-generated ID to the bookingID field
  //   booking.bookingID = bookingRef.id;
  //
  //   // Save the booking to Firestore
  //   await bookingRef.set(booking.toMap());
  // }

  Future<void> addBooking(Booking booking) async {
    // Generate a new document reference with an auto ID
    final bookingRef = FirebaseFirestore.instance.collection(bookingsCollection).doc();
    await bookingRef.set(booking.toMap());
  }

  Future<List<Booking>> getAllBookings() async {
    final querySnapshot = await FirebaseFirestore.instance.collection(bookingsCollection).get();

    return querySnapshot.docs.map((doc) => Booking.fromMap(doc.data(), doc.id)).toList();
  }

  // Future<List<Booking>> fetchBookings() async {
  //   final bookingSnapshot = await FirebaseFirestore.instance.collection('bookings').get();
  //   return bookingSnapshot.docs.map((doc) => Booking.fromMap(doc.data() as Map<String, dynamic>, doc.id)).toList();
  // }
}
