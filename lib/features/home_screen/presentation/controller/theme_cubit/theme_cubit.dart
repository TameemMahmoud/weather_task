import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../utils/helper/hive_helper.dart';
import 'theme_states.dart';


class ThemeCubit extends Cubit<ThemeStates> {
  ThemeCubit() : super(ThemeInitialState());

  static ThemeCubit get(context) => BlocProvider.of(context);

  bool isDark = false;
  void changeAppMode (){
    isDark = !isDark;
    HiveHelper.setMood(isDark);
    emit(ChangeThemeState());
  }

}