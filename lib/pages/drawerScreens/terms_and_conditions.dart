// TODO Implement this library.
import 'package:flutter/material.dart';

import '../../utils/styles.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  static const String id = 'terms_and_conditions';

  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms and Conditions'),
        centerTitle: true,
        backgroundColor: AppColors.appBarBG,
        automaticallyImplyLeading: true,
        leading: BackButton(),
      ),
      backgroundColor: AppColors.greenLight,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Terms and Conditions',
                style: TextStyles.bold16.copyWith(fontSize: 24),
              ),
              const SizedBox(height: 20),
              const Text(
                '1. Introduction',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 10),
              const Text(
                'Welcome to our application. By accessing or using our services, you agree to be bound by the following terms and conditions. Please read them carefully.',
              ),
              const SizedBox(height: 20),
              const Text(
                '2. User Responsibilities',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 10),
              const Text(
                'As a user, you are responsible for maintaining the confidentiality of your account information and for all activities that occur under your account. You must notify us immediately of any unauthorized use of your account.',
              ),
              const SizedBox(height: 20),
              const Text(
                '3. Limitation of Liability',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 10),
              const Text(
                'We are not liable for any damages that may arise from the use or inability to use our services. This includes, but is not limited to, direct, indirect, incidental, punitive, and consequential damages.',
              ),
              const SizedBox(height: 20),
              const Text(
                '4. Changes to Terms',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 10),
              const Text(
                'We reserve the right to modify these terms at any time. Any changes will be effective immediately upon posting. Your continued use of the service following the posting of changes constitutes your acceptance of those changes.',
              ),
              const SizedBox(height: 20),
              const Text(
                '5. Contact Us',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 10),
              const Text(
                'If you have any questions about these terms, please contact us at AhmadMuneeb@gmail.com.',
              ),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Return to the previous screen
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.greenLight, // Match your theme
                    elevation: 15,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Back'),
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
