// TODO Implement this library.
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:online_ticket_booking/components/custom_textfield.dart';
import 'package:online_ticket_booking/components/my_big_button.dart';
import 'package:online_ticket_booking/utils/styles.dart';

import '../../components/refund_status_dialog.dart';
import '../../models/refund_status_model.dart';
import '../../utils/constants.dart';
import '../home_screen.dart';

class RefundStatusScreen extends StatefulWidget {
  static const String id = 'refundStatus';
  const RefundStatusScreen({super.key});

  @override
  State<RefundStatusScreen> createState() => _refundstatusState();
}

class _refundstatusState extends State<RefundStatusScreen> {
  List<RefundStatus> refundsRequests = [];
  final _refundReqController = TextEditingController();

  final CollectionReference refundRequestsCollection = firestore.collection(refundRequests);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0XFF30D15D),
        title: const Center(child: Text('Check Refund Status')),
        leading: BackButton(
          onPressed: () {
            Navigator.pushNamed(context, HomeScreen.id);
          },
        ),
      ),
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: BoxDecoration(gradient: gradientGreen),
        child: Column(
          children: [
            const SizedBox(height: 80),
            const Text(
              'Please enter booking no for refund request.',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 40),
            CustomTextField(controller: _refundReqController, hint: 'Enter Refund Request No'),
            const SizedBox(height: 50),
            MyBigButton(
              label: 'Check Status',
              onTap: () async {
                String refundId = _refundReqController.text.trim();

                if (refundId.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter a valid Refund Request No')),
                  );
                  return;
                }
                DocumentReference docRef = firestore.collection(refundRequests).doc(refundId);

                try {
                  DocumentSnapshot docSnapshot = await docRef.get();

                  if (docSnapshot.exists) {
                    RefundStatus refundStatus =
                        RefundStatus.fromMap(docSnapshot.data() as Map<String, dynamic>, docSnapshot.id);

                    // Show the popup with refund status details
                    showDialog(
                      context: context,
                      builder: (context) => RefundStatusDialog(refundStatus: refundStatus),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('No Refund found with the provided ID')),
                    );
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error retrieving refund status: $e')),
                  );
                }
              },
            ),
            const SizedBox(height: 20),
            Divider(),
            const SizedBox(height: 20),
            Center(
              child: Text(
                'My refund requests',
                style: TextStyle(
                  fontSize: 20,
                  color: AppColors.yellow,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Expanded(
              // color: Colors.red,
              // height: 300,
              child: StreamBuilder<QuerySnapshot>(
                stream: refundRequestsCollection.snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final refundDocs = snapshot.data!.docs;

                  if (refundDocs.isEmpty) {
                    return const Center(
                      child: Text(
                        'No Refund Requests Found',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: refundDocs.length,
                    itemBuilder: (context, index) {
                      final refundData = refundDocs[index].data() as Map<String, dynamic>;
                      final refundStatus = RefundStatus.fromMap(refundData, refundDocs[index].id);

                      return ListTile(
                        title: Text('Booking ID: ${refundStatus.bookingId}'),
                        subtitle: Text('Refund ID: ${refundStatus.id}'),
                        trailing: IconButton(
                          icon: const Icon(Icons.copy),
                          onPressed: () {
                            Clipboard.setData(
                              ClipboardData(text: refundStatus.id),
                            ).then(
                              (value) {
                                ScaffoldMessenger.of(context)
                                  ..hideCurrentSnackBar()
                                  ..showSnackBar(const SnackBar(content: Text('Refund ID Copied to clipboard')));
                              },
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
