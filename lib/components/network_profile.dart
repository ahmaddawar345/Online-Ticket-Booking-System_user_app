import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../utils/constants.dart';

class NetworkProfileImage extends StatelessWidget {
  final String imagePath;
  const NetworkProfileImage({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Center(
        child: Container(
          height: 95,
          width: 95,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imagePath == '' ? NetworkImage(onlineImageLink) : CachedNetworkImageProvider(imagePath) as ImageProvider,
              // NetworkImage(imagePath),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(100),
          ),
        ),
      ),
    );
  }
}
