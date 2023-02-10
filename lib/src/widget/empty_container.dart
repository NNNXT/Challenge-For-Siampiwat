// Flutter Modules
import 'package:flutter/material.dart';

class EmptyContainer extends StatelessWidget {
  final IconData icon;
  final String msg;

  const EmptyContainer({
    required this.icon,
    required this.msg,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon),
            const SizedBox(height: 8),
            Text(msg),
          ],
        ),
      );
}
