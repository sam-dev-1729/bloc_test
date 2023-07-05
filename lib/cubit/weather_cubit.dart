import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sam_test/weather_repository.dart';

import '../weather.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherRepository _weatherRepository;
  WeatherCubit(this._weatherRepository) : super(WeatherInitial());

  Future<void> getWeather(cityName) async {
    try {
      emit(WeatherLoading());
      final weather = await _weatherRepository.fetchWeather(cityName);
      emit(WeatherLoaded(weather));
    } on NetWorkException {
      emit(WeatherError('error to catch data from server'));
    }
  }
}
