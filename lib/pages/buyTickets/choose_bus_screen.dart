// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:online_ticket_booking/utils/styles.dart';
//
// import '../../components/bus_widget.dart';
// import '../../utils/constants.dart';
//
// class ChooseBus extends StatelessWidget {
//   final String departure;
//   final String arrival;
//   final String travelDate;
//
//   const ChooseBus({
//     super.key,
//     required this.departure,
//     required this.arrival,
//     required this.travelDate,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     String lDeparture = departure.toLowerCase();
//     String lArrival = arrival.toLowerCase();
//     // Filter buses based on the selected departure, arrival, and travel date
//     final filteredBuses = buses.where((bus) {
//       DateTime selectedDate = DateFormat('yyyy-MM-dd').parse(travelDate);
//       return bus.departure.toLowerCase() == lDeparture &&
//           bus.arrival.toLowerCase() == lArrival &&
//           bus.departureTime.isAtSameMomentAs(selectedDate);
//     }).toList();
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Available Buses'),
//         centerTitle: true,
//         backgroundColor: AppColors.appBarBG,
//       ),
//       backgroundColor: AppColors.greenLight,
//       body: Column(
//         children: [
//           SizedBox(
//             height: 80,
//             width: double.infinity,
//             child: Center(
//                 child: Text(
//               '$departure TO $arrival',
//               style: TextStyles.bold16.copyWith(fontSize: 20),
//             )),
//           ),
//           filteredBuses.isEmpty
//               ? const Expanded(
//                   child: Center(
//                     child: Text(
//                       'Sorry!!.. No bus is available for this route right now',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(fontSize: 20, color: Colors.black),
//                     ),
//                   ),
//                 )
//               : Expanded(
//                   child: ListView.builder(
//                     itemCount: filteredBuses.length,
//                     itemBuilder: (context, index) {
//                       final bus = filteredBuses[index];
//                       return BusWidget(bus: bus);
//                     },
//                   ),
//                 ),
//         ],
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:online_ticket_booking/components/bus_widget.dart';
import 'package:online_ticket_booking/models/bus_model.dart';
import 'package:online_ticket_booking/utils/constants.dart';

import '../../utils/styles.dart';

class ChooseBus extends StatefulWidget {
  final String departure;
  final String arrival;
  final String travelDate;

  const ChooseBus({
    super.key,
    required this.departure,
    required this.arrival,
    required this.travelDate,
  });

  @override
  State<ChooseBus> createState() => _ChooseBusState();
}

class _ChooseBusState extends State<ChooseBus> {
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    selectedDate = DateFormat('yyyy-MM-dd').parse(widget.travelDate);
  }

  /// this only determine route
  /// further time matching is done nn the builder function
  getBusesStream() {
    return firestore
        .collection(busesCollection)
        .where('departure', isEqualTo: widget.departure)
        .where('arrival', isEqualTo: widget.arrival)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Available Buses'),
        centerTitle: true,
        backgroundColor: AppColors.appBarBG,
      ),
      backgroundColor: AppColors.greenLight,
      body: Column(
        children: [
          SizedBox(
            height: 80,
            width: double.infinity,
            child: Center(
                child: Text(
              '${widget.departure} To ${widget.arrival}',
              style: TextStyles.bold16.copyWith(fontSize: 20),
            )),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: getBusesStream(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text(
                      'Sorry!!.. No bus is available',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  );
                }

                var buses = snapshot.data!.docs
                    .map((doc) => Bus.fromMap(doc.data() as Map<String, dynamic>, doc.id))
                    .where((bus) {
                  try {
                    DateTime dt = DateFormat('dd-MM-yyyy').parse(bus.departureDate);
                    return dt.isAtSameMomentAs(selectedDate);
                  } catch (e) {
                    print('Error parsing date: $e');
                    return false;
                  }
                }).toList();

                if (buses.isEmpty) {
                  return const Center(
                    child: Text(
                      'Sorry!!.. No bus is available for this route right now',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: buses.length,
                  itemBuilder: (context, index) {
                    final bus = buses[index];
                    return BusWidget(bus: bus);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
