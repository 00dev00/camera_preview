import 'package:camera/camera.dart';
import 'package:camera_preview/services/camera_service.dart';
import 'package:camera_preview/services/geo_service.dart';
import 'package:camera_preview/views/widgets/camera/camera_main.dart';
import 'package:camera_preview/views/widgets/init_failed.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final CameraService cameraService;
  late final GeoService geoService;

  Future<void> _init() async {
    await cameraService.init();
    await geoService.init();
  }

  @override
  void initState() {
    cameraService = CameraService();
    geoService = GeoService();
    super.initState();
  }

  @override
  void dispose() {
    cameraService.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _init(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            if (snapshot.error is CameraException) {
              return const InitFailed();
            } else {
              return const InitFailed(
                isGeoServiceFailed: true,
              );
            }
          }

          return const CameraMain();
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
