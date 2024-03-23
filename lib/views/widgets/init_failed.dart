import 'package:flutter/material.dart';

class InitFailed extends StatelessWidget {
  const InitFailed({
    this.isGeoServiceFailed = false,
    super.key,
  });

  final bool isGeoServiceFailed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isGeoServiceFailed ? Icons.public : Icons.no_photography,
            size: 50,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            isGeoServiceFailed
                ? "Geolocation service failed"
                : "Camera initialization failed",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ],
      ),
    );
  }
}
