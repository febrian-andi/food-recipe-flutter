import 'package:flutter/material.dart';

class InfoIcon extends StatelessWidget {
  final IconData icon;
  final String text;

  const InfoIcon({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 24, color: Colors.deepOrange),
        const SizedBox(height: 4),
        Text(
          text,
          style: const TextStyle(fontSize: 12),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}