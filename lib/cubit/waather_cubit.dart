import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../reposetory.dart';
import '../weather.dart';

part 'waather_state.dart';

class WeatherCubit extends Cubit<WaatherState> {
  final WeatherRepository weatherRepository;
  WeatherCubit(this.weatherRepository) : super(WeatherInitial());

  Future<void> getWeather(String cityName) async {
    try {
      emit(WeatherLoading());
      final weather = await weatherRepository.fetchWeather(cityName);
      emit(WeatherLoaded(weather: weather));
    } on NetworkException {
      emit(WeatherError(message: 'error mesage'));
    }
  }
}
