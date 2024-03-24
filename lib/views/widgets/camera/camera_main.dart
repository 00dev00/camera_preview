import 'package:camera/camera.dart';
import 'package:camera_preview/models/camera_info.dart';
import 'package:camera_preview/services/api_service.dart';
import 'package:camera_preview/services/camera_service.dart';
import 'package:camera_preview/services/geo_service.dart';
import 'package:camera_preview/views/widgets/camera/camera_layout.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class CameraMain extends StatefulWidget {
  const CameraMain({super.key});

  @override
  State<CameraMain> createState() => _CameraMainState();
}

class _CameraMainState extends State<CameraMain> {
  final cameraService = CameraService();
  final geoService = GeoService();
  bool showProgress = false;

  @override
  Widget build(BuildContext context) {
    final windowHeight = MediaQuery.sizeOf(context).height;
    final windowWidth = MediaQuery.sizeOf(context).width;

    return Stack(
      children: [
        if (windowHeight < 400)
          CameraHorizontalLayout(
            onButtonPress: _onButtonPress,
          )
        else
          CameraVerticalLayout(
            onButtonPress: _onButtonPress,
          ),
        if (showProgress)
          SizedBox.expand(
            child: Container(
              color: Colors.black87.withOpacity(0.4),
              child: const Center(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Future<void> _onButtonPress(BuildContext context, String comment) async {
    var scaffoldMessanger = ScaffoldMessenger.of(context);
    var theme = Theme.of(context);

    FocusManager.instance.primaryFocus?.unfocus();

    try {
      setState(() {
        showProgress = true;
      });
      final XFile image = await cameraService.getSnapshot();
      final Position position = await geoService.getCurrentPosition();

      final cameraInfo = CameraInfo(
        comment: comment,
        latitude: position.latitude,
        longitude: position.longitude,
        photo: image,
      );

      var (success, message) = await ApiService.sendInfo(cameraInfo);
      setState(() {
        showProgress = false;
      });

      final snackBar = SnackBar(
        backgroundColor: success
            ? theme.colorScheme.primaryContainer
            : theme.colorScheme.error,
        content: Text(
          message,
          style: TextStyle(
            color: success
                ? theme.colorScheme.onPrimaryContainer
                : theme.colorScheme.onError,
          ),
        ),
      );
      scaffoldMessanger.showSnackBar(snackBar);
    } on CameraException {
      const snackBar = SnackBar(
        content: Text("Camera failed to take a snapshot"),
      );

      scaffoldMessanger.showSnackBar(snackBar);
    } on Exception catch (ex) {
      final snackBar = SnackBar(
        content: Text(ex.toString()),
      );
      scaffoldMessanger.showSnackBar(snackBar);
    }
  }
}
