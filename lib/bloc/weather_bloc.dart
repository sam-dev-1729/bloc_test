import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../weather.dart';
import '../weather_repository.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository _weatherRepository;

  WeatherBloc(this._weatherRepository) : super(WeatherInitial()) {
    on<GetWeather>((event, emit) async {
      try {
        emit(WeatherLoading());
        final weather = await _weatherRepository.fetchWeather(event.cityName);
        emit(WeatherLoaded(weather));
      } on NetWorkException {
        emit(WeatherError('error to catch data from server'));
      }
    });
  }
  // in old version of bloc use [mapEventToState] to handle events
  // @override
  // Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
  //   if (event is GetWeather) {
  //     try {
  //       yield WeatherLoading();
  //       final weather = await _weatherRepository.fetchWeather(event.cityName);
  //       yield WeatherLoaded(weather);
  //     } on NetWorkException {
  //       yield (WeatherError('error to catch data from server'));
  //     }
  //   }
  // }
}
