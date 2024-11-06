// import 'package:flutter/material.dart';
// import 'package:online_ticket_booking/utils/styles.dart';
//
// import 'buyTickets/select_destination_screen.dart';
//
// class ChooseAgency extends StatefulWidget {
//   static const String id = 'chooseAgency';
//   const ChooseAgency({super.key});
//
//   @override
//   State<ChooseAgency> createState() => _ChooseAgencyState();
// }
//
// class _ChooseAgencyState extends State<ChooseAgency> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Center(child: Text('Select Travel Agency')),
//           backgroundColor: Colors.teal,
//         ),
//         body: Container(
//           constraints: const BoxConstraints.expand(),
//           decoration: BoxDecoration(gradient: gradientGreen),
//           child: SingleChildScrollView(
//             child: SafeArea(
//                 child: Column(
//               children: [
//                 const Center(),
//                 const SizedBox(height: 90),
//                 Container(
//                   width: 300,
//                   height: 80,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(15),
//                     color: Colors.green,
//                   ),
//                   child: Center(
//                     child: TextButton(
//                       onPressed: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => const SelectDestinationScreen(
//                                       agencyName: 'Dilawar Khan Coach',
//                                     )));
//                       },
//                       child: const Center(
//                         child: Text(
//                           'Dilawar Khan Coach',
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             fontSize: 20,
//                             fontFamily: 'Oswald-Medium',
//                             color: Colors.black,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 90),
//                 Container(
//                   width: 300,
//                   height: 80,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(15),
//                     color: Colors.brown,
//                   ),
//                   child: Center(
//                     child: TextButton(
//                       onPressed: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => const SelectDestinationScreen(agencyName: 'Ziauddin Coach')));
//                       },
//                       child: const Center(
//                         child: Text(
//                           'Ziauddin Coach',
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             fontSize: 20,
//                             fontFamily: 'Oswald-Medium',
//                             color: Colors.black,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 90),
//                 Container(
//                   width: 300,
//                   height: 80,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(15),
//                     color: Colors.orange,
//                   ),
//                   child: Center(
//                     child: TextButton(
//                       onPressed: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => const SelectDestinationScreen(
//                                       agencyName: 'Adil Shah Coach',
//                                     )));
//                       },
//                       child: const Center(
//                         child: Text(
//                           'Adil Shah Coach',
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             fontSize: 20,
//                             fontFamily: 'Oswald-Medium',
//                             color: Colors.black,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             )),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:online_ticket_booking/utils/constants.dart';
import 'package:provider/provider.dart';

import '../../components/agency_card.dart';
import '../../controllers/select_agancy_controller.dart';
import '../../models/agency_model.dart';
import '../../utils/styles.dart';
import 'select_destination_screen.dart';

class ChooseAgency extends StatefulWidget {
  static const String id = 'chooseAgency';
  const ChooseAgency({super.key});

  @override
  State<ChooseAgency> createState() => _ChooseAgencyState();
}

class _ChooseAgencyState extends State<ChooseAgency> {
  Stream<List<TravelAgency>> _getAgenciesStream() {
    Stream<QuerySnapshot<Map<String, dynamic>>> snapshots =
        FirebaseFirestore.instance.collection(agenciesCollection).snapshots();
    return snapshots.map((snapshot) => snapshot.docs.map((doc) => TravelAgency.fromJson(doc.data(), doc.id)).toList());
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Select Travel Agency')),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: BoxDecoration(gradient: gradientGreen),
        child: SingleChildScrollView(
          child: SafeArea(
            child: StreamBuilder<List<TravelAgency>>(
              stream: _getAgenciesStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                ///
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: height / 2.5),
                      child: const Text(
                        'No agencies available.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                        ),
                      ),
                    ),
                  );
                }

                ///
                final agencies = snapshot.data!;
                return Column(
                  children: agencies.map((agency) {
                    return AgencyCard(
                      agencyName: agency.name,
                      address: agency.address,
                      onTap: () {
                        context.read<AgencyController>().selectAgency(agency);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SelectDestinationScreen(),
                          ),
                        );
                      },
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
