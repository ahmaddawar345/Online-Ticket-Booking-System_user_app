import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:online_ticket_booking/pages/payment_method/payment_successfull.dart';

import '../../../../models/booking_model.dart';

class PaymentBottomSheet extends StatelessWidget {
  final Booking booking;

  const PaymentBottomSheet({Key? key, required this.booking}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Amount to be paid",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.grey),
                ),
                Text(
                  // 'Rs ${booking.price.toStringAsFixed(2)}',
                  'Rs ${1500}',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ListTile(
                leading: Image.asset('assets/jazz-cash-logo.png', width: 30),
                title: const Text("JazzCash Mobile Wallet"),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  _showJazzCashPayment(context, booking);
                }),
            const Divider(),
            // Add more payment options here if needed
          ],
        ),
      ),
    );
  }

  void _showJazzCashPayment(BuildContext context, Booking booking) {
    showModalBottomSheet(
      context: context,
      builder: (context) => JazzCashPaymentSheet(booking: booking),
      isScrollControlled: true,
    );
  }
}

class JazzCashPaymentSheet extends StatefulWidget {
  final Booking booking;

  const JazzCashPaymentSheet({Key? key, required this.booking}) : super(key: key);

  @override
  _JazzCashPaymentSheetState createState() => _JazzCashPaymentSheetState();
}

class _JazzCashPaymentSheetState extends State<JazzCashPaymentSheet> {
  String? responsePrice;
  bool isLoading = false;
  final _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 10,
            ),
          ],
        ),
        child: isLoading
            ? const Center(
                child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Payment is being processed...!!',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(height: 20),
                  CircularProgressIndicator(),
                ],
              ))
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Amount to be Paid:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const Text(
                    // 'Rs ${widget.booking.price.toStringAsFixed(2)}',
                    'Rs 1500',
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: 'Enter your Wallet number',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.phone),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      _showConfirmationDialog();
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Proceed to Payment'),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Future<void> payment() async {
    setState(() {
      isLoading = true;
    });

    String dateandtime = DateFormat("yyyyMMddHHmmss").format(DateTime.now());
    String dexpiredate = DateFormat("yyyyMMddHHmmss").format(DateTime.now().add(const Duration(days: 1)));
    String tre = "T" + dateandtime;
    // String pp_Amount = widget.booking.price.toString();
    String pp_Amount = 1500.toString();
    String pp_BillReference = "billRef";
    String pp_Description = "Booking payment for ${widget.booking.passengerName}";
    String pp_Language = "EN";
    String pp_MerchantID = "MC119730";
    String pp_Password = "us2x345auv";
    String pp_ReturnURL = "https://jazzcash.com";
    String pp_ver = "1.1";
    String pp_TxnCurrency = "PKR";
    String pp_TxnDateTime = dateandtime;
    String pp_TxnExpiryDateTime = dexpiredate;
    String pp_TxnRefNo = tre;
    String pp_TxnType = "MWALLET";
    String ppmpf_1 = "03360558708";
    String IntegritySalt = "99yg9a1sh8";
    String and = '&';

    String superdata = IntegritySalt +
        and +
        pp_Amount +
        and +
        pp_BillReference +
        and +
        pp_Description +
        and +
        pp_Language +
        and +
        pp_MerchantID +
        and +
        pp_Password +
        and +
        pp_ReturnURL +
        and +
        pp_TxnCurrency +
        and +
        pp_TxnDateTime +
        and +
        pp_TxnExpiryDateTime +
        and +
        pp_TxnRefNo +
        and +
        pp_TxnType +
        and +
        pp_ver +
        and +
        ppmpf_1;

    var key = utf8.encode(IntegritySalt);
    var bytes = utf8.encode(superdata);
    var hmacSha256 = Hmac(sha256, key);
    Digest sha256Result = hmacSha256.convert(bytes);

    String url = 'https://sandbox.jazzcash.com.pk/ApplicationAPI/API/Payment/DoTransaction';

    var response = await http.post(Uri.parse(url), body: {
      "pp_Version": pp_ver,
      "pp_TxnType": pp_TxnType,
      "pp_Language": pp_Language,
      "pp_MerchantID": pp_MerchantID,
      "pp_Password": pp_Password,
      "pp_TxnRefNo": tre,
      "pp_Amount": pp_Amount,
      "pp_TxnCurrency": pp_TxnCurrency,
      "pp_TxnDateTime": dateandtime,
      "pp_BillReference": pp_BillReference,
      "pp_Description": pp_Description,
      "pp_TxnExpiryDateTime": dexpiredate,
      "pp_ReturnURL": pp_ReturnURL,
      "pp_SecureHash": sha256Result.toString(),
      "ppmpf_1": ppmpf_1
    });

    var res = response.body;
    var body = jsonDecode(res);
    print('response ============================================================');
    print('response ============================================================');
    print(response.body);
    if (body['pp_Amount'] != null) {
      responsePrice = body['pp_Amount'];

      // String redirectUrl = body['pp_GatewayPageURL'] ?? pp_ReturnURL;
      //
      // await launchUrl(Uri.parse(redirectUrl));

      saveBooking();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Payment failed. Please check the details."),
          backgroundColor: Colors.red,
        ),
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<void> saveBooking() async {
    try {
      DocumentReference bookingRef = FirebaseFirestore.instance.collection('bookings').doc();
      await bookingRef.set(widget.booking.toMap());

      Get.offAll(() => PaymentSuccessful(responsePrice: double.parse(responsePrice!)));
      // Navigator.of(context).pushReplacement(MaterialPageRoute(
      //   builder: (context) => ,
      // ));
      // Fluttertoast.showToast(
      //     textColor: Colors.white,
      //     backgroundColor: Colors.blue,
      //     msg: 'Payment successful: $responsePrice\n'
      //         'Booking confirmed! Awaiting admin approval.');
    } catch (e) {
      Fluttertoast.showToast(msg: "Failed to save booking: $e");
    }
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirm Payment'),
          content: const Text('Are you sure'),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('NO'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    payment();
                  },
                  child: const Text('YES'),
                )
              ],
            )
          ],
        );
      },
    );
  }
}
