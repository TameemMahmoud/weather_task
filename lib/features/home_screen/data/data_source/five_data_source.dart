import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:weather_task/features/home_screen/data/model/five_days_model.dart';
import 'package:weather_task/features/home_screen/data/model/weather_model.dart';

import '../../../../utils/di/injection.dart';
import '../../../../utils/errors/exceptions.dart';
import '../../../../utils/log/log.dart';
import '../../../../utils/network/dio/enum.dart';
import '../../../../utils/network/dio/network_call.dart';
import '../../../../utils/network/urls/end_points.dart';

class FiveDataSource {
  Future<FiveDaysModel> getFiveDaysWeather({
    Map<String, dynamic>? body,
    Map<String, dynamic>? headers,
  }) async {
    late Response response;
    try {
      response = await instance<NetworkCall>().request(EndPoints.fiveDaysWeather,
          queryParameters: body,
          options: Options(method: Method.get.name, headers: headers));
    } catch (error) {
      print(error);
      throw ServerException();
    }
    var res = jsonDecode(response.data);
    Log.i(res.toString());
    if (res['cod'] == '200') {
      return FiveDaysModel.fromJson(res);
    } else {
      throw WrongDataException(res['message'].toString());
    }
  }
}
