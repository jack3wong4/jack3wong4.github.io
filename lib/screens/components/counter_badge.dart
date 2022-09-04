import 'package:customer_calendar/screens/components/constants.dart';
import 'package:flutter/material.dart';

class CounterBadge extends StatelessWidget {
  const CounterBadge({Key? key, required this.count}) : super(key: key);
  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
          color: kBadgeColor, borderRadius: BorderRadius.circular(9)),
      child: Text(
        count.toString(),
      ),
    );
  }
}
