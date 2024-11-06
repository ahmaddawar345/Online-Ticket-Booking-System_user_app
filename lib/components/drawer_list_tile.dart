import 'package:flutter/material.dart';

class DrawerListTile extends StatelessWidget {
  final String iconPath;
  final String title;
  final VoidCallback onTap;

  const DrawerListTile({
    super.key,
    required this.iconPath,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(iconPath, height: 35, width: 35),
      title: Text(title),
      onTap: onTap,
    );
  }
}
