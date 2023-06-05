import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'utils/app/my_app.dart';
import 'utils/bloc_obsever/bloc_observer.dart';
import 'utils/di/injection.dart';
import 'utils/helper/hive_helper.dart';
import 'utils/helper/location_helper.dart';


late PackageInfo packageInfo;
Position? position;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);


  await initAppInjection();
  await Hive.initFlutter();
  position = await LocationHelper.determinePosition();
  await Hive.openBox(HiveHelper.tempMood);
  await Hive.openBox(HiveHelper.mood);
  Bloc.observer = MyBlocObserver();
  packageInfo = await PackageInfo.fromPlatform();
  runApp(const MyApp());
}

