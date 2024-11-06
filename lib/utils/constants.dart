import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:online_ticket_booking/pages/my_bookings.dart';
import 'package:online_ticket_booking/pages/refund/check_refund_status_screen.dart';
import 'package:online_ticket_booking/pages/refund/refund_request_screen.dart';

import '../pages/buyTickets/selecttravelagency.dart';
import '../pages/feedBack/feebBack_screen.dart';

/// Strings names
const appNameText = "ONLINE TICKET BOOKING";
FirebaseAuth auth = FirebaseAuth.instance;
final firestore = FirebaseFirestore.instance;
final fireStore = FirebaseFirestore.instance;
String feedBackCollection = 'feedBackCollection';

/// collections names
String userCollection = 'users';
String bookingsCollection = 'bookings';
String busesCollection = 'buses';
String reservedSeats = 'reservedSeats';
String agenciesCollection = 'agencies';
String refundRequests = 'refundRequests';

///

String emptySeat = 'assets/aSeat.png'; // Default to available
String femaleSeat = 'assets/fSeat.png'; // Default to available
String maleSeat = 'assets/mSeat.png'; // Default to available

class IconImages {
  static const T_and_Cs = "assets/t and c.png";
  static const companyProfile = "assets/cprofile.png";
  static const profile = "assets/profile.png";
  static const home = "assets/home.png";
  static const contact = 'assets/contactus.png';
  static const logout = 'assets/logout.png';
}

class BImages {
  static const buyTickets = "assets/bticket.png";
  // static const myTickets = "assets/mticket.png";
  static const myBookings = "assets/mbooking.png";
  static const feedback = "assets/feedback.png";
  static const refund = "assets/refund.png";
  static const refundStatus = "assets/refunds.png";
}

final List<Map<String, dynamic>> homeScreenButtons = [
  {'iconPath': BImages.buyTickets, 'label': 'Buy Tickets', 'route': ChooseAgency.id},
  // {'iconPath': BImages.buyTickets, 'label': 'Buy Tickets', 'route': SelectDestinationScreen.id},
  // {'iconPath': BImages.myTickets, 'label': 'My Tickets', 'route': '/mytickets'},
  {'iconPath': BImages.myBookings, 'label': 'My Bookings', 'route': MyBookings.id},
  {'iconPath': BImages.feedback, 'label': 'Feedback', 'route': AddFeedbackScreen.id},
  {'iconPath': BImages.refund, 'label': 'Refund', 'route': RefundRequestScreen.id},
  {'iconPath': BImages.refundStatus, 'label': 'Refund Status', 'route': RefundStatusScreen.id},
];

String onlineImageLink =
    'https://img.freepik.com/free-vector/isolated-young-handsome-man-different-poses-white-background-illustration_632498-859.jpg?w=826&t=st=1715062290~exp='
    '1715062890~hmac=337a8779af734974db8bb7ffd481b570c14fdcee9cc4eac22218a75a9a60f60c';

// final List<Bus> buses = [
//   Bus(
//       busNumber: '1',
//       departure: 'Bannu',
//       arrival: 'Peshawar',
//       departureTime: DateTime(2024, 7, 28),
//       busName: 'Dilawar Khan'),
//   Bus(
//       busNumber: '2',
//       departure: 'Bannu',
//       arrival: 'Peshawar',
//       departureTime: DateTime(2024, 7, 28),
//       busName: 'Dilawar Khan'),
//   Bus(
//       busNumber: '3',
//       departure: 'Bannu',
//       arrival: 'islamabad',
//       departureTime: DateTime(2024, 7, 28),
//       busName: 'Dilawar Khan'),
//   Bus(
//       busNumber: '4',
//       departure: 'Islamabad',
//       arrival: 'Karachi',
//       departureTime: DateTime(2024, 7, 28),
//       busName: 'Dilawar Khan'),
// ];
