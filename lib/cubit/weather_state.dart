// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'weather_cubit.dart';

@immutable
abstract class WeatherState {}

class WeatherInitial extends WeatherState {
  WeatherInitial();
}

class WeatherLoading extends WeatherState {
  WeatherLoading();
}

class WeatherLoaded extends WeatherState {
  Weather weather;
  WeatherLoaded(this.weather);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WeatherLoaded && other.weather == weather;
  }

  @override
  int get hashCode => weather.hashCode;
}

class WeatherError extends WeatherState {
  final String message;
  WeatherError(this.message);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WeatherError && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
