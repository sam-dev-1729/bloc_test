// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'waather_cubit.dart';

@immutable
abstract class WaatherState {}

class WeatherInitial extends WaatherState {
  WeatherInitial();
}

class WeatherLoading extends WaatherState {
  WeatherLoading();
}

class WeatherLoaded extends WaatherState {
  final Weather weather;
  WeatherLoaded({required this.weather});
}

class WeatherError extends WaatherState {
  final String message;
  WeatherError({required this.message});
}
