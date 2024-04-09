import 'package:flutter/material.dart';

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String change;
  final IconData icon;
  final Color color;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.change,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.symmetric(vertical: 8, horizontal: 12), // Reduced padding
      decoration: BoxDecoration(
        color: color,
        borderRadius:
            BorderRadius.circular(12), // Slightly reduced border radius
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min, // To fit the content size
        children: [
          Icon(icon, color: Colors.white, size: 20), // Adjusted icon size
          SizedBox(height: 5), // Reduced spacing
          Text(
            title,
            style: TextStyle(
                color: Colors.white, fontSize: 14), // Adjusted text size
          ),
          SizedBox(height: 5),
          Text(
            value,
            style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold), // Adjusted text size
          ),
          SizedBox(height: 5),
          Text(
            change,
            style: TextStyle(
                color: Colors.white, fontSize: 12), // Adjusted text size
          ),
        ],
      ),
    );
  }
}
