// TODO Implement this library.
import 'package:flutter/material.dart';
import 'package:online_ticket_booking/components/custom_textfield.dart';
import 'package:online_ticket_booking/models/user_model.dart';
import 'package:online_ticket_booking/utils/constants.dart';
import 'package:online_ticket_booking/utils/styles.dart';
import 'package:provider/provider.dart';

import '../../controllers/profile_controller.dart';

class SignupScreen extends StatefulWidget {
  static const String id = 'dsignup';
  final VoidCallback toggleBetweenLoginSignUp;
  const SignupScreen({super.key, required this.toggleBetweenLoginSignUp});

  @override
  State<SignupScreen> createState() => _signupState();
}

class _signupState extends State<SignupScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nicController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool obscureText = true;
  bool isLoading = false;
  Future _saveForm() async {
    final controller = Provider.of<ProfileController>(context, listen: false);
    if (!_formKey.currentState!.validate()) {
      return;
    }
    setState(() => isLoading = true);
    final newUser = UserModel(
      name: nameController.text,
      email: emailController.text,
      phone: phoneController.text,
      nic: nicController.text,
      password: passwordController.text,
    );
    //signUp and create user
    await controller.signUp(newUser: newUser, context: context).then((value) {
      setState(() => isLoading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: BoxDecoration(
          gradient: gradientGreen,
        ),
        child: SingleChildScrollView(
          child: SafeArea(
              child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 50),
                Text(
                  appNameText,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 25,
                    color: AppColors.secondaryColor,
                  ),
                ),
                Text(
                  'Book ticket with ease',
                  style: TextStyle(
                    fontSize: 17,
                    color: AppColors.greenLight,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'SIGNUP',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 35),
                CustomTextField(controller: nameController, hint: 'Full Name'),
                CustomTextField(
                  controller: phoneController,
                  hint: 'phone No',
                  keyboardType: TextInputType.phone,
                ),
                CustomTextField(
                  controller: emailController,
                  hint: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter Email';
                    }
                    if (!value.contains('@')) {
                      return 'Invalid Email';
                    }
                    return null;
                  },
                ),
                CustomTextField(
                  controller: nicController,
                  hint: 'CNIC',
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter CNIC';
                    }
                    if (value.length < 5) {
                      return 'enter more than 5 characters';
                    }
                    return null;
                  },
                ),
                CustomTextField(
                  controller: passwordController,
                  hint: 'Password',
                  obscureText: obscureText,
                  toggleEyeIcon: () {
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
                  suffixIcon: obscureText ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter password';
                    } else if (value.length < 6) {
                      return 'Password should be at least 6 characters';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 20),
                Container(
                  width: 180,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.yellow,
                  ),
                  child: Center(
                    child: isLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : TextButton(
                            onPressed: () {
                              _saveForm();
                              // Navigator.pushNamed(context, LoginScreen.id);
                            },
                            child: const Center(
                              child: Text(
                                'Register',
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
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Don\'t have an account?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Oswald-Regular',
                        color: Colors.white,
                      ),
                    ),
                    TextButton(
                      onPressed: () => widget.toggleBetweenLoginSignUp(),
                      child: Center(
                        child: Text(
                          'Login',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Oswald-Medium',
                            color: AppColors.secondaryColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }
}
