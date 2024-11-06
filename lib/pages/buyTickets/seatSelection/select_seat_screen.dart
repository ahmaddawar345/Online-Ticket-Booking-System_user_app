import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:online_ticket_booking/models/bus_model.dart';
import 'package:online_ticket_booking/models/seat_model.dart';
import 'package:online_ticket_booking/pages/buyTickets/seatSelection/passenger_details_for_seat.dart';
import 'package:online_ticket_booking/utils/constants.dart';
import 'package:online_ticket_booking/utils/styles.dart';
import 'package:online_ticket_booking/utils/utils.dart';

class SelectSeatsScreen extends StatefulWidget {
  static const String id = 'Selection';
  final Bus bus;
  SelectSeatsScreen({super.key, required this.bus});

  @override
  State<SelectSeatsScreen> createState() => _SelectSeatsScreenState();
}

class _SelectSeatsScreenState extends State<SelectSeatsScreen> {
  late Stream<DocumentSnapshot> _busStream;
  Seat? reservedSeat;
  @override
  void initState() {
    super.initState();
    // Initialize the stream to listen to changes in the bus document
    final busDoc = firestore.collection(busesCollection).doc(widget.bus.busId);
    _busStream = busDoc.snapshots();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.appBarBG,
          title: const Center(child: Text("Seat Selection")),
          centerTitle: true,
        ),
        body: Container(
          decoration: BoxDecoration(gradient: gradientGreen),
          child: Column(
            children: [
              const SizedBox(height: 5),
              Center(
                child: Container(
                  width: width - 30,
                  height: 90,
                  decoration: BoxDecoration(
                    color: AppColors.greenLight.withAlpha(1),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SeatTypeWidget(imagePath: 'assets/aSeat.png', label: 'Available'),
                        SeatTypeWidget(imagePath: 'assets/fSeat.png', label: 'Female'),
                        SeatTypeWidget(imagePath: 'assets/mSeat.png', label: 'Male'),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Container(
                  width: width - 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 15,
                        spreadRadius: 5,
                        offset: Offset(5, 5),
                      )
                    ],
                    gradient: gradientGreen,
                  ),
                  child: StreamBuilder<DocumentSnapshot>(
                    stream: _busStream,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      Map<String, dynamic> reservedSeats = snapshot.data?['reservedSeats'] ?? {};

                      return GridView.builder(
                        padding: const EdgeInsets.all(20),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          mainAxisSpacing: 5,
                          crossAxisSpacing: 5,
                          childAspectRatio: 1,
                        ),
                        itemCount: snapshot.data?['capacity'],
                        itemBuilder: (context, index) {
                          final seatNumber = (index + 1).toString();
                          String seatStatusImage = emptySeat; // Default to available

                          if (reservedSeats.containsKey(seatNumber)) {
                            reservedSeat = Seat.fromJson(reservedSeats[seatNumber]);
                            if (reservedSeat!.gender == 'Female') {
                              seatStatusImage = femaleSeat;
                            } else if (reservedSeat!.gender == 'Male') {
                              seatStatusImage = maleSeat;
                            }
                          }

                          return SeatWidget(
                            seatNumber: seatNumber,
                            imagePath: seatStatusImage,
                            onTap: () {
                              reservedSeats.containsKey(seatNumber)
                                  ? (ScaffoldMessenger.of(context)
                                    ..hideCurrentMaterialBanner()
                                    ..showMaterialBanner(Utils.showBanner(seatNumber, context)))
                                  : Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => PassengerDetailsForSeat(
                                          seatNumber: int.parse(seatNumber),
                                          bus: widget.bus,
                                        ),
                                      ),
                                    );
                            },
                          );
                        },
                      );
                    },
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

class SeatTypeWidget extends StatelessWidget {
  final String imagePath;
  final String label;

  const SeatTypeWidget({
    super.key,
    required this.imagePath,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image(
          image: AssetImage(imagePath),
          height: 50,
          width: 50,
        ),
        Text(label),
      ],
    );
  }
}

class SeatWidget extends StatelessWidget {
  final String seatNumber;
  final String imagePath;
  final VoidCallback onTap;

  const SeatWidget({
    super.key,
    required this.seatNumber,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          IconButton(
            iconSize: 40,
            icon: Image(
              image: AssetImage(imagePath),
            ),
            onPressed: null,
          ),
          Text(seatNumber),
        ],
      ),
    );
  }
}
