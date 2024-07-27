import 'package:flutter/material.dart';

class WeatherDetailTile extends StatelessWidget {
  WeatherDetailTile(
      {super.key,
      required this.icon,
      required this.label,
      required this.value,
      this.color = Colors.white});
  IconData icon;
  String label;
  String value;
  Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 20, color: Colors.white),
          ),
          Row(
            children: [
              Text(
                value,
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(width: 10),
              Icon(icon, color: color),
            ],
          ),
        ],
      ),
    );
  }
}
