import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:online_ticket_booking/utils/styles.dart';

import 'choose_bus_screen.dart';

class SelectDestinationScreen extends StatefulWidget {
  static const String id = 'SelectDestinationScreen';

  const SelectDestinationScreen({super.key});

  @override
  State<SelectDestinationScreen> createState() => _SelectDestinationScreenState();
}

class _SelectDestinationScreenState extends State<SelectDestinationScreen> {
  TextEditingController dateInput = TextEditingController();
  String? selectedDeparture;
  String? selectedArrival;

  final List<String> locations = [
    'Bannu',
    'Peshawar',
    'Islamabad',
    'Karachi',
    'Lahore',
    // Add more locations if needed
  ];

  @override
  void initState() {
    super.initState();
    dateInput.text = ""; // Set the initial value of the text field
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0XFF30D15D),
        title: const Center(child: Text('Choose your destination')),
        centerTitle: true,
      ),
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: BoxDecoration(gradient: gradientGreen),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 40),
                child: Row(
                  children: [
                    Icon(
                      Icons.pin_drop_outlined,
                      color: AppColors.greenDark,
                      size: 20,
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      'Departure From',
                      style: TextStyle(fontSize: 17),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: DropdownButton<String>(
                      value: selectedDeparture,
                      iconSize: 40,
                      hint: const Text(
                        'Select Departure Terminal',
                        style: TextStyle(fontSize: 17),
                      ),
                      isExpanded: true,
                      style: const TextStyle(fontSize: 20, color: Colors.black),
                      items: locations.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedDeparture = value;
                        });
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, top: 40),
                child: Row(
                  children: [
                    Icon(
                      Icons.pin_drop_outlined,
                      color: AppColors.greenDark,
                      size: 20,
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      'Arrival at',
                      style: TextStyle(fontSize: 17),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: DropdownButton<String>(
                      value: selectedArrival,
                      iconSize: 40,
                      hint: const Text(
                        'Select Arrival Terminal',
                        style: TextStyle(fontSize: 17),
                      ),
                      isExpanded: true,
                      style: const TextStyle(fontSize: 20, color: Colors.black),
                      items: locations.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedArrival = value;
                        });
                      },
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20, top: 40),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Travel Date",
                    style: TextStyle(fontSize: 17),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: const EdgeInsets.all(15),
                  child: Center(
                    child: TextField(
                      controller: dateInput,
                      decoration: const InputDecoration(
                        icon: Image(image: AssetImage('assets/calendar.png')),
                        labelText: "Travel Date",
                      ),
                      readOnly: true,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1950),
                          lastDate: DateTime(2100),
                        );

                        if (pickedDate != null) {
                          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                          setState(() {
                            dateInput.text = formattedDate; // Set output date to TextField value.
                          });
                        } else {
                          print('No date selected');
                        }
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Container(
                width: 180,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.yellow,
                ),
                child: Center(
                  child: TextButton(
                    onPressed: () {
                      if (selectedDeparture != null && selectedArrival != null && dateInput.text.isNotEmpty) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChooseBus(
                              departure: selectedDeparture!,
                              arrival: selectedArrival!,
                              travelDate: dateInput.text,
                            ),
                          ),
                        );
                      }
                    },
                    child: const Center(
                      child: Text(
                        'Find Bus',
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
            ],
          ),
        ),
      ),
    );
  }
}
