import 'package:geolocator/geolocator.dart';

import 'package:location/location.dart'as location;
import 'package:quickalert/quickalert.dart';
import 'package:weather_task/utils/app/my_app.dart';

class LocationHelper {
  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  static Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await location.Location().requestService();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      QuickAlert.show(
        context: navigatorKey.currentState!.context,
        type: QuickAlertType.error,
        title: 'بيانات موقعك',
        text: 'Please, ',
      );
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        QuickAlert.show(
          context: navigatorKey.currentState!.context,
          type: QuickAlertType.error,
          title: 'Location Service',
          text: 'Please, let the app access to your location',
        );
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    //var pos = await Geolocator.getLastKnownPosition();
    // print(pos);
    // if(pos!=null)
    //   return pos;
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
  }

  // static void onLocationError(e) {
  //   CommonUtils.showDialog(
  //     GeneralDialog(
  //       title: S.current.location,
  //       message: S.current.invalid_location_error,
  //       iconName: 'ic_warining_dialog',
  //       callback: (ok) async {
  //         await Location().requestService();
  //         Get.back();
  //       },
  //     ),
  //   );
  // }
}
