// import 'package:flutter/material.dart';
//
// import '../../../DUMMY/confirm_booking_details.dart';
//
// class SeatDetailScreen extends StatefulWidget {
//   final int seatNumber;
//   const SeatDetailScreen({super.key, required this.seatNumber});
//
//   @override
//   State<SeatDetailScreen> createState() => _SeatDetailScreenState();
// }
//
// class _SeatDetailScreenState extends State<SeatDetailScreen> {
//   String _selectedOption = '';
//
//   void _handleOptionChange(String? value) {
//     setState(() {
//       _selectedOption = value!;
//     });
//   }
//
//   void _handleButtonPress(String action) {
//     // Handle the button press
//     print('Button pressed: $action');
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color(0XFF30D15D),
//         title: const Center(child: Text('Select Options')),
//       ),
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               Color(0XFF0CF14C),
//               Color(0XFF265533),
//             ],
//             begin: Alignment.topRight,
//             end: Alignment.bottomLeft,
//           ),
//         ),
//         child: Column(
//           children: [
//             const SizedBox(height: 10),
//             const SizedBox(height: 3),
//             SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   children: [
//                     SizedBox(height: 150),
//                     Padding(
//                       padding: const EdgeInsets.only(left: 20, right: 3),
//                       child: Column(
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: <Widget>[
//                               Flexible(
//                                 child: RadioListTile(
//                                   title: const Text('For self'),
//                                   value: 'self',
//                                   groupValue: _selectedOption,
//                                   onChanged: _handleOptionChange,
//                                 ),
//                               ),
//                               Flexible(
//                                 child: RadioListTile(
//                                   title: const Text('For Family'),
//                                   value: 'For Family',
//                                   groupValue: _selectedOption,
//                                   onChanged: _handleOptionChange,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 20.0), // Add some space between the radio buttons and the buttons
//                           Padding(
//                             padding: const EdgeInsets.only(left: 0, right: 7),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: <Widget>[
//                                 SizedBox(
//                                   width: 150, // Set the width you want
//                                   height: 40, // Set the height you want
//                                   child: ElevatedButton.icon(
//                                     onPressed: () => _handleButtonPress('Male'),
//                                     label: const Text('Male'),
//                                     icon: const Padding(
//                                       padding: EdgeInsets.only(left: 0, right: 20, top: 10, bottom: 10),
//                                       // child: Image(
//                                       //image: AssetImage('assets/mseat.png'),
//                                       // ),
//                                     ),
//                                   ),
//                                 ),
//                                 const SizedBox(
//                                   width: 10,
//                                 ),
//                                 SizedBox(
//                                   width: 150, // Set the width you want
//                                   height: 40, // Set the height you want
//                                   child: ElevatedButton.icon(
//                                     onPressed: () => _handleButtonPress('Female'),
//                                     label: const Text('Female'),
//                                     icon: const Padding(
//                                       padding: EdgeInsets.only(left: 0, right: 20, top: 10, bottom: 10),
//                                       //child: Image(
//                                       //  image: AssetImage('assets/fseat.png'),
//                                       //),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           const SizedBox(
//                             height: 20,
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Container(
//                               width: 350,
//                               height: 40,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(15),
//                                 color: Colors.yellow,
//                               ),
//                               child: Center(
//                                 child: TextButton(
//                                   onPressed: () {
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(builder: (context) => dbookingdetails()),
//                                     );
//                                   },
//                                   child: const Center(
//                                     child: Text(
//                                       'Confirm',
//                                       textAlign: TextAlign.center,
//                                       style: TextStyle(
//                                         fontSize: 16,
//                                         fontFamily: 'Oswald-Medium',
//                                         color: Colors.black,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
///
import 'package:flutter/material.dart';
import 'package:online_ticket_booking/components/custom_textfield.dart';
import 'package:online_ticket_booking/controllers/profile_controller.dart';
import 'package:online_ticket_booking/models/bus_model.dart';
import 'package:online_ticket_booking/models/passenger_model.dart';
import 'package:online_ticket_booking/models/seat_model.dart';
import 'package:online_ticket_booking/pages/buyTickets/confirm_booking_details.dart';
import 'package:online_ticket_booking/utils/constants.dart';
import 'package:provider/provider.dart';

import '../../../utils/styles.dart';

class PassengerDetailsForSeat extends StatefulWidget {
  static const String id = 'SeatDetailScreen';
  final int seatNumber;
  final Bus bus;

  const PassengerDetailsForSeat({super.key, required this.seatNumber, required this.bus});

  @override
  State<PassengerDetailsForSeat> createState() => _PassengerDetailsForSeatState();
}

class _PassengerDetailsForSeatState extends State<PassengerDetailsForSeat> {
  String? gender; // To store the selected gender
  TextEditingController nameController = TextEditingController();
  TextEditingController nicController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();

    final profileController = Provider.of<ProfileController>(context, listen: false);
    profileController.currentUser;
    nameController.text = profileController.currentUser.name;
    nicController.text = profileController.currentUser.nic;
    phoneController.text = profileController.currentUser.phone;
  }

  void confirmSeat() {
    if (gender != null) {
      ///seat info
      Seat confirmedSeat = Seat(
        seatNo: widget.seatNumber.toString(),
        gender: gender!,
        reserved: false,
        userId: auth.currentUser!.uid,
      );

      ///passenger info
      final passenger = PassengerModel(
        passengerName: nameController.text,
        passengerPhone: phoneController.text,
        passengerNIC: nicController.text,
        passengerGender: gender!,
      );

      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ConfirmBookingDetails(
              passenger: passenger,
              seat: confirmedSeat,
              bus: widget.bus,
            ),
          ));
    } else {
      // Show an alert or message indicating that gender selection is required
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Please select gender to continue.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void dispose() {
    // Dispose of the controllers when the widget is removed from the widget tree
    nameController.dispose();
    nicController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter Details'),
        backgroundColor: AppColors.appBarBG,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: gradientGreen,
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Enter Passenger Details for Seat ',
                        style: TextStyles.bold18.copyWith(fontSize: 20),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: AppColors.greenDark,
                        ),
                        child: Text(
                          '${widget.seatNumber}',
                          style: TextStyles.bold18.copyWith(color: AppColors.yellow, fontSize: 25),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: nameController,
                hint: 'Name',
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: nicController,
                hint: 'Email',
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: phoneController,
                hint: 'Phone Number',
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 25),
              const Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Text(
                  'Gender',
                  style: TextStyles.bold18,
                ),
              ),
              Row(
                children: [
                  Radio(
                    value: 'Male',
                    groupValue: gender,
                    fillColor: const WidgetStatePropertyAll(Colors.white),
                    activeColor: Colors.black,
                    onChanged: (value) {
                      setState(() {
                        gender = value;
                      });
                    },
                  ),
                  const Text(
                    'Male',
                    style: TextStyle(color: Colors.white),
                  ),
                  Radio(
                    value: 'Female',
                    fillColor: const WidgetStatePropertyAll(Colors.white),
                    groupValue: gender,
                    onChanged: (value) {
                      setState(() {
                        gender = value;
                      });
                    },
                  ),
                  const Text('Female', style: TextStyle(color: Colors.white)),
                ],
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Container(
                    width: 350,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.yellow,
                    ),
                    child: Center(
                      child: TextButton(
                        onPressed: () {
                          confirmSeat();
                        },
                        child: const Center(
                          child: Text(
                            'Confirm',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Oswald-Medium',
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
