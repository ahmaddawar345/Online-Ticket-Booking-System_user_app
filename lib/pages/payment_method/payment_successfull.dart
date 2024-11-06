import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_ticket_booking/pages/home_screen.dart';

class PaymentSuccessful extends StatelessWidget {
  final double responsePrice;
  const PaymentSuccessful({super.key, required this.responsePrice});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 80,
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Payment Successful  :  ',
                  style: TextStyle(fontSize: 22),
                ),
                Text(
                  responsePrice.toString(),
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.green),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const SizedBox(height: 10),
            const Text(
              'Booking confirmed!',
              style: TextStyle(fontSize: 20),
            ),
            const Spacer(),
            CupertinoButton(
              onPressed: () {
                Get.offAll(() => const HomeScreen());
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    CupertinoIcons.back,
                    color: Colors.blue,
                  ),
                  SizedBox(width: 4),
                  Text(
                    'Go Home',
                    style: const TextStyle(fontSize: 20, color: Colors.blue),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
