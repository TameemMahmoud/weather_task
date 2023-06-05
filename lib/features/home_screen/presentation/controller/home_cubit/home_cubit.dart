import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_task/features/home_screen/data/data_source/five_data_source.dart';
import 'package:weather_task/features/home_screen/data/model/five_days_model.dart';
import 'package:weather_task/features/home_screen/data/model/weather_model.dart';
import 'package:weather_task/features/home_screen/data/repo/current_repo.dart';
import 'package:weather_task/features/home_screen/data/repo/five_days_repo.dart';
import 'package:weather_task/utils/resources/error_messages.dart';

import '../../../../../utils/app/my_app.dart';
import '../../../../../utils/di/injection.dart';
import '../../../../../utils/errors/failures.dart';
import '../../../../../utils/helper/hive_helper.dart';
import '../../../../../utils/network/connection/network_info.dart';
import '../../../../../utils/network/urls/services_urls.dart';
import '../../../../../utils/resources/snackbar_widget.dart';
import '../../../data/data_source/current_data_source.dart';
import 'home_states.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  final CurrentRepo _currentRepo = CurrentRepo(
    networkInfo: instance<NetworkInfoImp>(),
    currentDataSource: CurrentDataSource(),
  );

  WeatherModel? currentWeather;

  bool isCelsius = true;

  void getCurrentWeather({
    required BuildContext context,
    required String city,
    required bool isCelsius,
    String? lng,
    String? lat,
  }) {
    print('ttt');
    emit(
      GetCurrentWeatherLoadingState(),
    );
    // showLoadingDialog(context, dismissible: false);
    _currentRepo
        .getCurrentWeather(
            body: lat == null
                ? {
                    'appid': ServicesURLs.apiKey,
                    'q': city,
                    'units': HiveHelper.getTempMood() ? 'metric' : 'standard',
                  }
                : {
                    'appid': ServicesURLs.apiKey,
                    'lat': lat,
                    'lon': lng,
                    'units': isCelsius ? 'metric' : 'standard',
                  })
        .then((value) {
      // dismissLoadingDialog(context);
      value.fold((l) {
        String error = '';
        if (l is OffLineFailure) {
          failSnackBar(ErrorMessages.internetError, '', context);
        } else if (l is WrongDataFailure) {
          failSnackBar(
              l.message.toString(), ErrorMessages.dataEntryError, context);
        } else if (l is ServerFailure) {
          failSnackBar(ErrorMessages.serverError, '', context);
        }
        emit(GetCurrentWeatherErrorState());
      }, (r) {
        currentWeather = r;
        emit(
          GetCurrentWeatherSuccessState(),
        );
        // Navigator.pushNamed(context, SplashScreen.routeName);
      });
    });
  }

  final FiveDaysRepo _fiveDaysRepo = FiveDaysRepo(
    networkInfo: instance<NetworkInfoImp>(),
    fiveDataSource: FiveDataSource(),
  );

  FiveDaysModel? fiveDaysModel;

  void getFiveDaysWeather({
    required BuildContext context,
    required String city,
    required bool isCelsius,
    String? lng,
    String? lat,
  }) {
    print('ttt');
    emit(
      GetFiveDaysWeatherLoadingState(),
    );
    // showLoadingDialog(context, dismissible: false);
    _fiveDaysRepo
        .getFiveDaysWeather(
            body: lat == null
                ? {
                    'appid': ServicesURLs.apiKey,
                    'q': city,
                    'units': isCelsius ?  'metric' : 'standard',
                  }
                : {
                    'appid': ServicesURLs.apiKey,
                    'lat': lat,
                    'lon': lng,
                    'units': HiveHelper.getTempMood() ? 'metric' : 'standard',
                  })
        .then((value) {
      // dismissLoadingDialog(context);
      value.fold((l) {
        String error = '';
        if (l is OffLineFailure) {
          failSnackBar(ErrorMessages.internetError, '', context);
        } else if (l is WrongDataFailure) {
          failSnackBar(
              l.message.toString(), ErrorMessages.dataEntryError, context);
        } else if (l is ServerFailure) {
          failSnackBar(ErrorMessages.serverError, '', context);
        }
        emit(GetFiveDaysWeatherErrorState());
      }, (r) {
        fiveDaysModel = r;
        emit(
          GetFiveDaysWeatherSuccessState(),
        );
        // Navigator.pushNamed(context, SplashScreen.routeName);
      });
    });
  }

  void changeTempMode() {
    isCelsius = !isCelsius;
    HiveHelper.setTempMood(isCelsius);
    emit(ChangeTempState());
  }
}
