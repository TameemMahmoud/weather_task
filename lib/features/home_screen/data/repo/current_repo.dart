import 'package:dartz/dartz.dart';
import 'package:weather_task/features/home_screen/data/model/weather_model.dart';

import '../../../../utils/errors/exceptions.dart';
import '../../../../utils/errors/failures.dart';
import '../../../../utils/network/connection/network_info.dart';
import '../data_source/current_data_source.dart';

class CurrentRepo {
  NetworkInfo networkInfo;
  CurrentDataSource currentDataSource;

  CurrentRepo({required this.networkInfo, required this.currentDataSource});

  Future<Either<Failure, WeatherModel>> getCurrentWeather(
      {Map<String, dynamic>? body, Map<String, dynamic>? headers}) async {
    if (await networkInfo.isConnected) {
      try {
        WeatherModel result =
        await currentDataSource.getCurrentWeather(body: body, headers: headers);
        return right(result);
      } on WrongDataException catch (message) {
        return left(WrongDataFailure(message: message.message));
      } on ServerException {
        return left(ServerFailure());
      }

    } else {
      return Left(OffLineFailure());
    }
  }

}