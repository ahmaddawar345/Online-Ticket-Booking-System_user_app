import 'package:flutter/material.dart';

class Utils {
  static final messengerKey = GlobalKey<ScaffoldMessengerState>();

  ///
  static showErrorSnackBar(String errorMsg) {
    if (errorMsg == '') return;
    final snackBar = SnackBar(content: Text(errorMsg), backgroundColor: Colors.red);
    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static showSuccessSnackBar(String msg) {
    if (msg == '') return;
    final snackBar = SnackBar(content: Text(msg), backgroundColor: Colors.green);
    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static showBanner(String seatNumber, BuildContext context) {
    return MaterialBanner(
      content: Text('Seat $seatNumber is already reserved'),
      actions: [
        ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).clearMaterialBanners();
            },
            child: const Text('Okay')),
      ],
    );
  }
}

/// function for navigation
navigateTo(screenName, BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => screenName,
    ),
  );
}
