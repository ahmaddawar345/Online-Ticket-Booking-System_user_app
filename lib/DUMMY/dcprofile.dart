// // TODO Implement this library.
// import 'package:flutter/material.dart';
//
// import '../pages/home_screen.dart';
//
// class CompanyProfile extends StatefulWidget {
//   static const String id = 'companyprofile';
//   const CompanyProfile({Key? key}) : super(key: key);
//
//   @override
//   State<CompanyProfile> createState() => _cprofileState();
// }
//
// class _cprofileState extends State<CompanyProfile> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: SafeArea(
//           child: Scaffold(
//         appBar: AppBar(
//           leading: BackButton(
//             onPressed: () {
//               Navigator.pushNamed(context, HomeScreen.id);
//             },
//           ),
//           backgroundColor: const Color(0XFF30D15D),
//           title: const Center(child: Text('Company Profile')),
//           /*actions: [
//             IconButton(T
//                 onPressed: () {},
//                 icon: const Icon(Icons.notifications_outlined)),
//           ],*/
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
//           child: Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Container(
//               child: const Text('0335 9866762'
//                   '03329970176'),
//             ),
//           ),
//         ),
//       )),
//     );
//   }
// }
