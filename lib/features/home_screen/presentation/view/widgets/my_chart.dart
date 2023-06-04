import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:weather_task/features/home_screen/data/model/five_days_model.dart';
import 'package:weather_task/features/home_screen/presentation/controller/home_cubit/home_cubit.dart';
import 'package:weather_task/utils/resources/constants.dart';

class MyChart extends StatelessWidget {
  final HomeCubit cubit;
  MyChart({Key? key, required this.cubit}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.pagePadding),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.pagePadding),
        child: SfCartesianChart(
          primaryXAxis: CategoryAxis(),
            series: <ChartSeries<WeatherInfo, String>>[
              LineSeries<WeatherInfo, String>(
                  dataSource: cubit.fiveDaysModel!.list,
                  xValueMapper: (WeatherInfo days, _) => DateFormat('E, ha').format(DateTime.parse(days.dtTxt)),
                  yValueMapper: (WeatherInfo temp, _) => temp.main.temp.round(),
                  name: 'Sales',
                  // Enable data label
                  dataLabelSettings: DataLabelSettings(isVisible: true))
            ]
        ),
      ),
    );
  }
}


