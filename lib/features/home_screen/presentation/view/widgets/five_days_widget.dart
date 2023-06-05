import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_task/utils/resources/app_fonts.dart';
import 'package:weather_task/utils/resources/constants.dart';
import 'package:weather_task/utils/resources/icons.dart';

import '../../../../../utils/resources/app_colors.dart';
import '../../../data/model/five_days_model.dart';

class FiveDaysWidget extends StatelessWidget {
  final WeatherInfo data;

  const FiveDaysWidget({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            AppConstants.pagePadding,
          ),
        ),
        elevation: 4,
        shadowColor: AppColors.mainColor,
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.pagePadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                DateFormat().add_MMMMEEEEd().format(DateTime.parse(data.dtTxt)),
              ),
              Text(
                DateFormat('ha').format(DateTime.parse(data.dtTxt)),
              ),
              Text(data.weather[0].description.toUpperCase(), style: AppFonts.headlineStyle.copyWith(color: Colors.grey),),
              Icon(weatherIcon(data.weather[0].icon)),
              const SizedBox(height: 10,),
              Text('${(data.main.temp).round().toString()}\u2103', style: AppFonts.headlineStyle.copyWith(color: AppColors.mainColor),),
              Text(
                'min: ${(data.main.tempMin).round().toString()}\u2103 / max: ${(data.main.tempMax).round().toString()}\u2103',
                style: AppFonts.smallFont
                    .copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'wind ${data.wind.speed} m/s',
                style: AppFonts.smallFont
                    .copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

