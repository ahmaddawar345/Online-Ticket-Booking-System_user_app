import 'package:flutter/cupertino.dart';

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
