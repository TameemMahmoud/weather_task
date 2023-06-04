import 'package:dartz/dartz.dart';
import 'package:weather_task/features/home_screen/data/model/five_days_model.dart';
import 'package:weather_task/features/home_screen/data/model/weather_model.dart';

import '../../../../utils/errors/exceptions.dart';
import '../../../../utils/errors/failures.dart';
import '../../../../utils/network/connection/network_info.dart';
import '../data_source/current_data_source.dart';
import '../data_source/five_data_source.dart';

class FiveDaysRepo {
  NetworkInfo networkInfo;
  FiveDataSource fiveDataSource;

  FiveDaysRepo({required this.networkInfo, required this.fiveDataSource});

  Future<Either<Failure, FiveDaysModel>> getFiveDaysWeather(
      {Map<String, dynamic>? body, Map<String, dynamic>? headers}) async {
    if (await networkInfo.isConnected) {
      try {
        FiveDaysModel result =
        await fiveDataSource.getFiveDaysWeather(body: body, headers: headers);
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