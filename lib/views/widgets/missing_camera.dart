import 'package:flutter/material.dart';

class MissingCamera extends StatelessWidget {
  const MissingCamera({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.no_photography,
            size: 50,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Camera initialization failed",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ],
      ),
    );
  }
}
