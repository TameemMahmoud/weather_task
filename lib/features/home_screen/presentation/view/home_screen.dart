import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:quickalert/quickalert.dart';
import 'package:weather_task/features/home_screen/presentation/view/widgets/five_days_widget.dart';
import 'package:weather_task/features/home_screen/presentation/view/widgets/home_header.dart';
import 'package:weather_task/utils/resources/app_colors.dart';
import 'package:weather_task/utils/resources/app_fonts.dart';
import 'package:weather_task/utils/resources/constants.dart';

import '../controller/home_cubit/home_cubit.dart';
import '../controller/home_cubit/home_states.dart';
import 'widgets/my_chart.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/HomeScreen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  String? _information;

  String? _currentAddress;
  Position? _currentPosition;

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Location Services',
        text: 'Please, Let the app access to your location',
      );
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'بيانات الموقع الحالي',
        text: 'الرجاء تفعيل بيانات الموقع من الهاتف',
      );
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
        _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
        '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeStates>(builder: (context, state) {
      var cubit = HomeCubit.get(context);
      return Scaffold(
        body: state is GetCurrentWeatherLoadingState ||
                cubit.currentWeather == null
            ? const Center(
                child: CircularProgressIndicator.adaptive(),
              )
            : SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: <Widget>[
                    HomeHeader(
                      cubit: cubit,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      '5-days forecast',
                      style: AppFonts.headlineStyle
                          .copyWith(color: AppColors.mainColor),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    state is GetFiveDaysWeatherLoadingState ||
                            cubit.fiveDaysModel == null
                        ? const Center(
                            child: CircularProgressIndicator.adaptive(),
                          )
                        : SizedBox(
                            height: 230,
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: cubit.fiveDaysModel!.list.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return FiveDaysWidget(
                                  data: cubit.fiveDaysModel!.list[index],
                                );
                              },
                            ),
                          ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      '5-days forecast by chart',
                      style: AppFonts.headlineStyle
                          .copyWith(color: AppColors.mainColor),
                    ),
                    state is GetFiveDaysWeatherLoadingState ||
                            cubit.fiveDaysModel == null
                        ? const Center(
                            child: CircularProgressIndicator.adaptive(),
                          )
                        : Padding(
                            padding:
                                const EdgeInsets.all(AppConstants.pagePadding),
                            child: MyChart(
                              cubit: cubit,
                            ),
                          ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
      );
    });
  }
}
