import 'dart:math';

import 'package:sam_test/weather.dart';

abstract class WeatherRepository {
  Future<Weather> fetchWeather(String cityName);
}

// simulate to interact with server
class FakeWeatherRepository extends WeatherRepository {
  @override
  Future<Weather> fetchWeather(String cityName) async {
    await Future.delayed(const Duration(seconds: 1));

    int temperture = Random().nextInt(200);
    Weather weather = Weather(cityName: cityName, temperture: temperture);
    if (Random().nextBool()) {
      throw NetWorkException();
    }

    // print() 'temperture of $cityName is $temperture';
    return weather;
  }
}

class NetWorkException implements Exception {}
