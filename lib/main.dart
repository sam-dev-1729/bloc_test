import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sam_test/cubit/waather_cubit.dart';
import 'package:sam_test/weather.dart';

import 'reposetory.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: BlocProvider(
        create: (context) => WeatherCubit(FakeWeatherRepository()),
        child: const WeatherSearchPage(),
      ),
    );
  }
}

class WeatherSearchPage extends StatefulWidget {
  const WeatherSearchPage({super.key});

  @override
  State<WeatherSearchPage> createState() => _WeatherSearchPageState();
}

class _WeatherSearchPageState extends State<WeatherSearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather Search"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        alignment: Alignment.center,
        child: BlocConsumer<WeatherCubit, WaatherState>(
          listener: (context, state) {
            if (state is WeatherError) {
              //Scaffold.of(context).showBodyScrim(true, 1);
              log('message');
              showDialog(
                context: context,
                builder: (context) {
                  return const AlertDialog(
                    title: Text('text'),
                  );
                },
              );
            }
          },
          builder: (context, state) {
            if (state is WeatherInitial) {
              return buildInitialInput(context);
            } else if (state is WeatherLoading) {
              return buildLoading();
            } else if (state is WeatherLoaded) {
              return buildColumnWithData(context, state.weather);
            } else {
              // (state is WeatherError)
              return buildInitialInput(context);
            }
          },
        ),
      ),
    );
  }

  buildInitialInput(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 70,
          width: 500,
          // margin: const EdgeInsets.only(left: 100, right: 100),
          child: TextFormField(
            onFieldSubmitted: (value) => onSubmit(context, value),
            //textInputAction: TextInputAction.search,
            decoration: const InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent)),
                hintText: 'input something',
                suffixIcon: Icon(Icons.search)),
          ),
        ),
      ],
    );
  }

  onSubmit(BuildContext context, String cityName) {
    BlocProvider.of<WeatherCubit>(context).getWeather(cityName);
  }

  buildLoading() {
    return const CircularProgressIndicator();
  }

  buildColumnWithData(BuildContext context, Weather weather) {
    return Column(
      children: <Widget>[
        Text(weather.cityName),
        Text(weather.tempeture.toString()),
        buildInitialInput(context)
      ],
    );
  }
}
