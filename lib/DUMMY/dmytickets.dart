// // TODO Implement this library.
// import 'package:flutter/material.dart';
//
// import '../pages/home_screen.dart';
//
// class dmytickets extends StatefulWidget {
//   static const String id = 'dmytickets';
//   const dmytickets({Key? key}) : super(key: key);
//
//   @override
//   State<dmytickets> createState() => _myticketsState();
// }
//
// class _myticketsState extends State<dmytickets> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         appBar: AppBar(
//           backgroundColor: const Color(0XFF30D15D),
//           title: const Center(child: Text('My Tickets')),
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
//                 SizedBox(height: 80),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 30),
//                   child: Row(
//                     children: [
//                       Container(
//                         width: 120,
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
//                                 'Upcoming',
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
//                       SizedBox(width: 50),
//                       Container(
//                         width: 120,
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
//                                 'History',
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
// // TODO Implement this library.
