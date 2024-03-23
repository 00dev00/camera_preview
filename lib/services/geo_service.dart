import 'package:geolocator/geolocator.dart';

final class GeoService {
  bool _serviceInitialized = false;
  static final _sharedInstance = GeoService._();
  factory GeoService() => _sharedInstance;

  GeoService._();

  Future<void> init() async {
    bool serviceEnabled;
    LocationPermission permission;

    if (!_serviceInitialized) {
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return Future.error("Location services are disabled");
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return Future.error('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately.
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      _serviceInitialized = true;
    }
  }

  Future<Position> getCurrentPosition() async {
    await init();

    final pos = await Geolocator.getCurrentPosition();
    return pos;
  }
}
