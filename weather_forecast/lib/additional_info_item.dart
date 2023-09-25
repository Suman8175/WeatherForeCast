import 'package:flutter/material.dart';

class AdditionalInfoItem extends StatelessWidget {
  final IconData iconsfinal;
  final String humidity;
  final String value;
  const AdditionalInfoItem({
    super.key,
    required this.iconsfinal,
    required this.humidity,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 24, bottom: 24),
      child: Column(
        children: [
          Icon(
            iconsfinal,
            size: 35,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 9),
            child: Text(
              humidity,
              style: const TextStyle(fontSize: 20),
            ),
          ),
          Text(value, style: const TextStyle(fontSize: 20)),
        ],
      ),
    );
  }
}
