import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:quickalert/quickalert.dart';
import 'package:weather_task/features/home_screen/presentation/controller/home_cubit/home_cubit.dart';
import 'package:weather_task/features/home_screen/presentation/controller/theme_cubit/theme_cubit.dart';
import 'package:weather_task/features/home_screen/presentation/controller/theme_cubit/theme_states.dart';
import 'package:weather_task/main.dart';
import '../../features/splash_screen/presentation/splash_screen.dart';
import '../helper/hive_helper.dart';
import '../resources/app_config.dart';
import '../resources/theme_controller.dart';

var navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
    BlocProvider<HomeCubit>(
    create: (context)
    =>
    HomeCubit()
      ..getCurrentWeather(context: navigatorKey.currentState!.context,
        city: '',
        lat: position!.latitude.toString(),
        lng: position!.longitude.toString(),)

    ..getFiveDaysWeather(context: navigatorKey.currentState!.context,
      city: '',
      lat: position!.latitude.toString(),
      lng: position!.longitude.toString(),),
    ),
    BlocProvider<ThemeCubit>(
    create: (context) => ThemeCubit(),
    ),
    ],
    child: BlocBuilder<ThemeCubit, ThemeStates>(
    builder: (context, state) {
    return MaterialApp(
    navigatorKey: navigatorKey,
    title: 'Weather App',
    localizationsDelegates: AppConfig.localizationsDelegates,
    supportedLocales: const [
    Locale('en'),
    ],
    locale: const Locale('en'),
    debugShowCheckedModeBanner: false,
    theme: Styles.themeData(HiveHelper.getMood(), context),
    home: const SplashScreen(),
    );
    }
    )
    ,
    );
  }
}
