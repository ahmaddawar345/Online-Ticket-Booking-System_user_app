// import 'package:flutter/material.dart';
// import 'package:online_ticket_booking/utils/styles.dart';
//
// import '../../DUMMY/home_screen.dart';
// import '../../utils/constants.dart';
//
// class LoginScreen extends StatefulWidget {
//   final VoidCallback toggleBetweenLoginSignUp;
//   static const String id = 'dloginscreen';
//   const LoginScreen({super.key, required this.toggleBetweenLoginSignUp});
//
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   bool obscureText = true;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         constraints: const BoxConstraints.expand(),
//         decoration: BoxDecoration(gradient: gradientGreen),
//         child: SafeArea(
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 // const Row(
//                 //   mainAxisAlignment: MainAxisAlignment.center,
//                 //   crossAxisAlignment: CrossAxisAlignment.center,
//                 //   children: [
//                 //     Image(
//                 //       image: AssetImage('assets/dlogo.png'),
//                 //     ),
//                 //   ],
//                 // ),nk
//                 const Text(
//                   appNameText,
//                   style: TextStyle(
//                     fontWeight: FontWeight.w700,
//                     fontSize: 25,
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 const Text(
//                   'LOGIN',
//                   style: TextStyle(
//                     fontWeight: FontWeight.w700,
//                     fontSize: 20,
//                     color: Colors.yellow,
//                   ),
//                 ),
//                 const SizedBox(height: 40),
//
//                 Padding(
//                   padding: const EdgeInsets.only(left: 15, right: 15),
//                   child: TextFormField(
//                     decoration: InputDecoration(
//                       hintText: 'Email',
//                       fillColor: const Color(0xfffce4ec),
//                       filled: true,
//                       prefixIcon: const Icon(
//                         Icons.email,
//                         color: Colors.green,
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderSide: const BorderSide(color: Color(0xff2D3142)),
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderSide: const BorderSide(color: Color(0xff2D3142)),
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 15, right: 15),
//                   child: TextFormField(
//                     decoration: InputDecoration(
//                       hintText: 'Password',
//                       fillColor: const Color(0xfffce4ec),
//                       filled: true,
//                       prefixIcon: const Icon(Icons.lock_open, color: Colors.green),
//                       suffixIcon: const Icon(Icons.visibility, color: Colors.green),
//                       focusedBorder: OutlineInputBorder(
//                         borderSide: const BorderSide(color: Color(0xff2D3142)),
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderSide: const BorderSide(color: Color(0xff2D3142)),
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 6),
//                 const Padding(
//                   padding: EdgeInsets.only(right: 20),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       Text(
//                         'Forget Password?',
//                         style: TextStyle(fontSize: 15, color: Colors.black, decoration: TextDecoration.underline),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 70),
//                 Container(
//                   width: 180,
//                   height: 50,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(15),
//                     color: Colors.yellow,
//                   ),
//                   child: Center(
//                     child: TextButton(
//                       onPressed: () {
//                         Navigator.pushNamed(context, HomeScreen.id);
//                       },
//                       child: const Center(
//                         child: Text(
//                           'Login',
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontFamily: 'Oswald-Medium',
//                             color: Colors.black,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Text(
//                       'Dont have an account?',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontFamily: 'Oswald-Regular',
//                         color: Color(0xff2D3142),
//                       ),
//                     ),
//                     TextButton(
//                       onPressed: () => widget.toggleBetweenLoginSignUp(),
//                       child: const Center(
//                         child: Text(
//                           'Sign Up',
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontFamily: 'Oswald-Medium',
//                             color: Colors.yellow,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
// // TODO Implement this library.
import 'package:flutter/material.dart';
import 'package:online_ticket_booking/components/custom_textfield.dart';
import 'package:online_ticket_booking/utils/constants.dart';
import 'package:online_ticket_booking/utils/styles.dart';
import 'package:provider/provider.dart';

import '../../controllers/profile_controller.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback toggleBetweenLoginSignUp;
  static const String id = 'loginscreen';
  const LoginScreen({super.key, required this.toggleBetweenLoginSignUp});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool obscureText = true;
  bool isLoading = false;

  Future _login() async {
    final controller = Provider.of<ProfileController>(context, listen: false);
    if (!_formKey.currentState!.validate()) {
      return;
    }
    setState(() => isLoading = true);
    // Perform login action
    await controller
        .signIn(
      email: emailController.text,
      password: passwordController.text,
      context: context,
    )
        .then((value) {
      setState(() => isLoading = false);
      // Navigator.pushNamed(context, HomeScreen.id);
    });
  }

  final _formKey = GlobalKey<FormState>();

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
                  const SizedBox(height: 130),
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
                  const SizedBox(height: 25),
                  const Text(
                    'LOGIN',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 35),
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
                      if (value == null || value.isEmpty) {
                        return 'Enter Password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  //LOGIN BUTTON
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
                                _login();
                              },
                              child: const Center(
                                child: const Center(
                                  child: Text(
                                    'Login',
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

                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Dont have an account?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Oswald-Regular',
                          color: Color(0xff2D3142),
                        ),
                      ),
                      TextButton(
                        onPressed: () => widget.toggleBetweenLoginSignUp(),
                        child: const Center(
                          child: Text(
                            'Sign Up',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Oswald-Medium',
                              color: Colors.yellow,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
