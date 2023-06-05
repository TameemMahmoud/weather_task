import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_task/features/home_screen/presentation/controller/theme_cubit/theme_cubit.dart';
import 'package:weather_task/features/home_screen/presentation/controller/theme_cubit/theme_states.dart';
import 'package:weather_task/utils/helper/hive_helper.dart';
import 'package:weather_task/utils/resources/app_colors.dart';
import 'package:weather_task/utils/resources/app_fonts.dart';
import 'package:weather_task/utils/resources/constants.dart';

import '../../../../../utils/resources/images.dart';
import '../../../../../widgets/animated_image.dart';
import '../../../data/model/weather_model.dart';
import '../../controller/home_cubit/home_cubit.dart';

class HomeHeader extends StatelessWidget {
  final HomeCubit cubit;

  HomeHeader({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.45,
      child: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.41,
            child: const Card(
              elevation: 5,
              shadowColor: AppColors.mainColor,
              margin: EdgeInsets.all(0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(40),
                  bottomLeft: Radius.circular(40),
                ),
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: AnimatedImage(
                imageUrl:
                    'https://img.freepik.com/free-photo/cloud-blue-sky_1232-3108.jpg?w=1800&t=st=1685811567~exp=1685812167~hmac=9adaabe5c78995b3cda4579825a2b90f460d4c89bdac93421a403fcc178f52b1',
              ),
            ),
          ),
          Positioned(
            top: 40,
            right: 20,
            child: Row(
              children: [
                AnimSearchBar(
                  prefixIcon: const Icon(IconlyBroken.search),
                  width: MediaQuery.of(context).size.width * 0.65,
                  textController: textController,
                  suffixIcon: const Icon(IconlyBroken.search),
                  closeSearchOnSuffixTap: false,
                  color: Theme.of(context).cardColor,
                  onSuffixTap: () {
                    if (textController.text.isNotEmpty) {
                      cubit.getCurrentWeather(
                        context: context,
                        city: textController.text,
                        isCelsius: HiveHelper.getTempMood(),
                      );
                      cubit.getFiveDaysWeather(
                        context: context,
                        city: textController.text,
                        isCelsius: HiveHelper.getTempMood(),
                      );
                    }
                  },
                  onSubmitted: (value) {
                    print(value);
                  },
                ),
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      AppConstants.pagePadding,
                    ),
                  ),
                  elevation: 4,
                  child: IconButton(
                    onPressed: () {
                      ThemeCubit.get(context).changeAppMode();
                    },
                    icon: const Icon(Icons.brightness_4_outlined),
                  ),
                ),
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      AppConstants.pagePadding,
                    ),
                  ),
                  elevation: 4,
                  child: IconButton(
                    onPressed: () {
                      cubit.changeTempMode();
                    },
                    icon: HiveHelper.getTempMood()
                        ? const Text('\u2103')
                        : const Text('\u2109'),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.pagePadding),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(AppConstants.pagePadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Center(
                            child: Text(
                              cubit.currentWeather!.name!.toUpperCase(),
                              style: AppFonts.cityFont,
                            ),
                          ),
                          Center(
                            child: Text(
                              DateFormat()
                                  .add_MMMMEEEEd()
                                  .format(DateTime.now()),
                              style: AppFonts.smallFont,
                            ),
                          ),
                        ],
                      ),
                      const Divider(),
                      //TODO
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text(
                                  cubit.currentWeather!.weather![0].description!
                                          .toUpperCase() ??
                                      '',
                                  style: AppFonts.smallFont
                                      .copyWith(fontSize: 20)),
                              const SizedBox(height: 10),
                              Text(
                                '${(cubit.currentWeather!.main!.temp!).round().toString()} ${HiveHelper.getTempMood() ? '\u2103' : '\u2109'}',
                                style:
                                    Theme.of(context).textTheme.displayMedium!,
                              ),
                              Text(
                                'min: ${(cubit.currentWeather!.main!.tempMin!).round().toString()}${HiveHelper.getTempMood() ? '\u2103' : '\u2109'} / max: ${(cubit.currentWeather!.main!.tempMax!).round().toString()}${HiveHelper.getTempMood() ? '\u2103' : '\u2109'}',
                                style: AppFonts.smallFont.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                width: 120,
                                height: 120,
                                child: Lottie.asset(Images.cloudyAnim),
                              ),
                              Text(
                                'wind ${cubit.currentWeather!.wind!.speed} m/s',
                                style: AppFonts.smallFont.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
