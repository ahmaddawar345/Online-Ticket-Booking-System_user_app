import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_ticket_booking/controllers/profile_controller.dart';
import 'package:online_ticket_booking/controllers/select_agancy_controller.dart';
import 'package:online_ticket_booking/pages/auth/auth_screen.dart';
import 'package:online_ticket_booking/pages/buyTickets/select_destination_screen.dart';
import 'package:online_ticket_booking/pages/buyTickets/selecttravelagency.dart';
import 'package:online_ticket_booking/pages/drawerScreens/terms_and_conditions.dart';
import 'package:online_ticket_booking/pages/feedBack/feebBack_screen.dart';
import 'package:online_ticket_booking/pages/home_screen.dart';
import 'package:online_ticket_booking/pages/my_bookings.dart';
import 'package:online_ticket_booking/utils/constants.dart';
import 'package:online_ticket_booking/utils/utils.dart';
import 'package:provider/provider.dart';

import 'DUMMY/dchangepassword.dart';
import 'DUMMY/dpaymentmethod.dart';
import 'controllers/booking_controller.dart';
import 'firebase_options.dart';
import 'pages/refund/check_refund_status_screen.dart';
import 'pages/refund/refund_request_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProfileController()),
        ChangeNotifierProvider(create: (context) => AgencyController()),
        ChangeNotifierProvider(create: (context) => BookingController()),
      ],
      builder: (context, child) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        scaffoldMessengerKey: Utils.messengerKey,
        title: 'Online Ticket Booking',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routes: {
          HomeScreen.id: (context) => const HomeScreen(),
          SelectDestinationScreen.id: (context) => const SelectDestinationScreen(),
          MyBookings.id: (context) => const MyBookings(),
          ChooseAgency.id: (context) => const ChooseAgency(),
          AddFeedbackScreen.id: (context) => const AddFeedbackScreen(),
          TermsAndConditionsScreen.id: (context) => const TermsAndConditionsScreen(),
          RefundRequestScreen.id: (context) => const RefundRequestScreen(),
          RefundStatusScreen.id: (context) => const RefundStatusScreen(),
          dchangepassword.id: (context) => const dchangepassword(),
          dpaymentmethod.id: (context) => const dpaymentmethod(),
        },
        home: StreamBuilder(
          stream: auth.userChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            ///
            else if (!snapshot.hasData) {
              return AuthScreen();
            }

            ///
            else {
              return const HomeScreen();
            }
          },
        ),
      ),
    );
  }
}
