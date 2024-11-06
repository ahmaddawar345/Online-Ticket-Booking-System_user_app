import 'package:flutter/material.dart';

class MyBigButton extends StatelessWidget {
  final String label;
  final Function onTap;
  const MyBigButton({
    super.key,
    required this.label,
    required this.onTap,
    // required Null Function() onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.yellow,
      ),
      child: Center(
        child: TextButton(
          onPressed: () => onTap(),
          child: Center(
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontFamily: 'Oswald-Medium',
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
