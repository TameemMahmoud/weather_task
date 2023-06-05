abstract class HomeStates {}

class HomeInitialState extends HomeStates {}

class GetCurrentWeatherLoadingState extends HomeStates {}

class GetCurrentWeatherSuccessState extends HomeStates {}

class GetCurrentWeatherErrorState extends HomeStates {}

class GetFiveDaysWeatherLoadingState extends HomeStates {}

class GetFiveDaysWeatherSuccessState extends HomeStates {}

class GetFiveDaysWeatherErrorState extends HomeStates {}

class ChangeTempState extends HomeStates {}