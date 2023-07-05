import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sam_test/reposetory.dart';

import '../weather.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository repository;
  WeatherBloc(this.repository) : super(WeatherInitial()) {
    on<WeatherEvent>((event, emit) {
      // TODO: implement event handler
      if (event is GetWeather) {}
    });
  }
}
