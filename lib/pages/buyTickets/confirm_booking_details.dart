import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:online_ticket_booking/components/my_big_button.dart';
import 'package:online_ticket_booking/controllers/booking_controller.dart';
import 'package:online_ticket_booking/controllers/select_agancy_controller.dart';
import 'package:online_ticket_booking/models/booking_model.dart';
import 'package:online_ticket_booking/models/bus_model.dart';
import 'package:online_ticket_booking/models/seat_model.dart';
import 'package:online_ticket_booking/pages/payment_method/jazzcash_payment_bottomsheet.dart';
import 'package:online_ticket_booking/utils/constants.dart';
import 'package:online_ticket_booking/utils/styles.dart';
import 'package:provider/provider.dart';

import '../../controllers/profile_controller.dart';
import '../../models/passenger_model.dart';

class ConfirmBookingDetails extends StatefulWidget {
  static const String id = "confirmBookingDetails";
  final PassengerModel passenger;
  final Seat seat;
  final Bus bus;
  const ConfirmBookingDetails({super.key, required this.seat, required this.bus, required this.passenger});

  @override
  State<ConfirmBookingDetails> createState() => _ConfirmBookingDetailsState();
}

class _ConfirmBookingDetailsState extends State<ConfirmBookingDetails> {
  Seat? seat;
  Bus? bus;
  PassengerModel? passenger;
  // bool isLoading = false;

  @override
  void initState() {
    super.initState();
    bus = widget.bus;
    seat = widget.seat;
    passenger = widget.passenger;
  }

  bookSeat() {
    // setState(() {
    //   isLoading = true;
    // });

    //profile controller
    final profileController = Provider.of<ProfileController>(context, listen: false);
    final user = profileController.currentUser;

    ///booking controller
    final bookingController = Provider.of<BookingController>(context, listen: false);

    // creating new booking instance
    /// booking id will be auto assigned by firebase
    Booking newBooking = Booking(
      bookingID: '',
      userID: auth.currentUser!.uid,
      busId: bus!.busId,
      agencyName: context.read<AgencyController>().selectedAgency!.name,
      seatNumber: seat!.seatNo,
      passengerName: passenger!.passengerName,
      passengerPhone: passenger!.passengerPhone,
      passengerNIC: passenger!.passengerNIC,
      passengerGender: passenger!.passengerGender,
      status: "pending",
      from: bus!.departure,
      to: bus!.arrival,
      bookingTime: DateFormat('yyyy-MM-dd').parse(bus!.departureDate),
      departureDate: bus!.departureDate,
      departureTime: bus!.departureTime,
    );
    print(newBooking.toMap());

    // Get.to(PaymentScreen(booking: newBooking));
    showModalBottomSheet(
      context: context,
      builder: (context) => PaymentBottomSheet(booking: newBooking),
    );

    /// book the seat
    // bookingController.addBooking(newBooking).then(
    //   (value) {
    //     setState(() {
    //       isLoading = false;
    //     });
    //   },
    // ).then(
    //   (value) {
    //     Navigator.pushNamedAndRemoveUntil(
    //       context,
    //       HomeScreen.id, // Use the route ID of the home screen
    //       (Route<dynamic> route) => false, // This removes all routes
    //     );
    //     // Navigator.popUntil(context, ModalRoute.withName(HomeScreen.id));
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0XFF30D15D),
          title: const Center(child: Text('Confirm Booking Details')),
        ),
        body: Container(
          decoration: BoxDecoration(gradient: gradientGreen),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: width - 30,
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: gradientGreen,
                    ),
                    child: SizedBox(
                      width: (width - 60),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          KeyValueTextRow(label: 'Seat No :', value: seat!.seatNo),
                          KeyValueTextRow(
                              label: 'Agency Name', value: context.read<AgencyController>().selectedAgency!.name),
                          KeyValueTextRow(label: 'From :', value: bus!.departure),
                          KeyValueTextRow(label: 'To', value: bus!.arrival),
                          KeyValueTextRow(label: 'Date', value: bus!.departureDate),
                          KeyValueTextRow(label: 'Time', value: bus!.departureTime),
                          KeyValueTextRow(label: 'Bus No :', value: bus!.busNumber),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // isLoading
                //     ? circularIndicator
                //     :
                MyBigButton(
                    label: 'Confirm and Request',
                    onTap: () {
                      bookSeat();
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class KeyValueTextRow extends StatelessWidget {
  final String label;
  final String value;
  const KeyValueTextRow({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyles.bold18,
          ),
          SizedBox(
            width: (MediaQuery.of(context).size.width - 65) / 2,
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
