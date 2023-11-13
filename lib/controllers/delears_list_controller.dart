import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:nerofix/utils/app_essentials.dart';
import 'package:permission_handler/permission_handler.dart';

class DelearsListController extends GetxController {
  String? street;
  String? city;
  RxBool isLocationLoaded = false.obs;
  @override
  onInit() {
    getLocation();
    super.onInit();
  }

  Future<void> getLocation() async {
    try {
      PermissionStatus status = await Permission.location.request();

      if (status.isGranted) {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );

        List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude,
          position.longitude,
        );

        Placemark firstPlacemark = placemarks.first;
        street = firstPlacemark.street ?? 'NA';
        city = firstPlacemark.locality ?? 'NA';

        isLocationLoaded.value = true;
      } else if (status.isDenied) {
      } else if (status.isPermanentlyDenied) {}
    } catch (e) {
      AppEssential.errorLog(e);
    }
  }
}
