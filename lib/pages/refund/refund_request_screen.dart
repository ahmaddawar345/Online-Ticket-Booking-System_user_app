// // TODO Implement this library.
// import 'package:flutter/material.dart';
//
// import '../DUMMY/check_refund_status_screen.dart';
// import 'home_screen.dart';
//
// class RefundRequestScreen extends StatefulWidget {
//   static const String id = 'drefundrequest';
//
//   const RefundRequestScreen({Key? key}) : super(key: key);
//
//   @override
//   State<RefundRequestScreen> createState() => _refundrequestState();
// }
//
// class _refundrequestState extends State<RefundRequestScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         appBar: AppBar(
//           backgroundColor: const Color(0XFF30D15D),
//           title: const Center(child: Text('Refund Request')),
//           leading: BackButton(
//             onPressed: () {
//               Navigator.pushNamed(context, HomeScreen.id);
//             },
//           ),
//         ),
//         body: Container(
//           constraints: const BoxConstraints.expand(),
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               colors: [
//                 Color(0XFF0CF14C),
//                 Color(0XFF265533),
//               ],
//               begin: Alignment.topRight,
//               end: Alignment.bottomLeft,
//             ),
//           ),
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 const SizedBox(height: 80),
//                 const Text('Please enter booking no for refund request.'),
//                 const SizedBox(height: 40),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 15, right: 15),
//                   child: TextFormField(
//                     decoration: InputDecoration(
//                       hintText: 'Enter Booking No',
//                       fillColor: const Color(0xfffce4ec),
//                       filled: true,
//                       focusedBorder: OutlineInputBorder(
//                         borderSide: const BorderSide(color: Color(0xff2D3142)),
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderSide: const BorderSide(color: Color(0xff2D3142)),
//                         borderRadius: BorderRadius.circular(30),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 40),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 80),
//                   child: Row(
//                     children: [
//                       Container(
//                         width: 200,
//                         height: 50,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(15),
//                           color: Colors.yellow,
//                         ),
//                         child: Center(
//                           child: TextButton(
//                             onPressed: () {},
//                             child: const Center(
//                               child: Text(
//                                 'Continue',
//                                 textAlign: TextAlign.center,
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   fontFamily: 'Oswald-Medium',
//                                   color: Colors.black,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 80),
//                   child: Row(
//                     children: [
//                       Container(
//                         width: 200,
//                         height: 50,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(15),
//                           color: Colors.yellow,
//                         ),
//                         child: Center(
//                           child: TextButton(
//                             onPressed: () {
//                               Navigator.pushNamed(context, drefundstatus.id);
//                             },
//                             child: const Center(
//                               child: Text(
//                                 'Check Refund Status',
//                                 textAlign: TextAlign.center,
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   fontFamily: 'Oswald-Medium',
//                                   color: Colors.black,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:online_ticket_booking/components/custom_textfield.dart';

import '../../models/refund_status_model.dart';
import '../../utils/constants.dart';
import '../home_screen.dart';
import 'check_refund_status_screen.dart';

class RefundRequestScreen extends StatefulWidget {
  static const String id = 'drefundrequest';

  const RefundRequestScreen({Key? key}) : super(key: key);

  @override
  State<RefundRequestScreen> createState() => _RefundRequestScreenState();
}

class _RefundRequestScreenState extends State<RefundRequestScreen> {
  final TextEditingController _bookingIdController = TextEditingController();
  final TextEditingController _refundReasonController = TextEditingController();

  Future<void> _submitRefundRequest() async {
    String bookingId = _bookingIdController.text.trim();
    String refundReason = _refundReasonController.text.trim();

    if (bookingId.isEmpty || refundReason.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    // Generate a unique ID for the refund request
    String id = firestore.collection(refundRequests).doc().id;

    // Create RefundStatus instance
    RefundStatus refundStatus = RefundStatus(
      id: id,
      refundReason: refundReason,
      bookingId: bookingId,
      status: 'pending',
    );

    // Save refund request to Firestore
    await firestore.collection(refundRequests).doc(id).set(refundStatus.toMap()).then(
      (value) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Refund request submitted')),
        );
      },
    );

    // Clear the form
    _bookingIdController.clear();
    _refundReasonController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0XFF30D15D),
        title: const Center(child: Text('Refund Request')),
        leading: BackButton(
          onPressed: () {
            Navigator.pushNamed(context, HomeScreen.id);
          },
        ),
      ),
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0XFF0CF14C),
              Color(0XFF265533),
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 80),
              const Text('Please enter booking details for a refund request.'),
              const SizedBox(height: 40),
              CustomTextField(
                controller: _bookingIdController,
                hint: 'Enter Booking No',
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: _refundReasonController,
                hint: 'Enter Refund Reason',
                lines: 3,
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 80),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.yellow,
                      ),
                      child: TextButton(
                        onPressed: _submitRefundRequest,
                        child: const Center(
                          child: Text(
                            'Submit Request',
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
                    const SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.yellow,
                      ),
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, RefundStatusScreen.id);
                        },
                        child: const Center(
                          child: Text(
                            'Check Refund Status',
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
