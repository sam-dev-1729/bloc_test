import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sam_test/bloc/weather_bloc.dart';
import 'package:sam_test/weather.dart';
import 'package:sam_test/weather_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: BlocProvider(
        create: (context) => WeatherBloc(FakeWeatherRepository()),
        child: const Home(),
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(vsync: this);
    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Title'),
        ),
        body: BlocConsumer<WeatherBloc, WeatherState>(
          listener: (context, state) {
            if (state is WeatherError) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text(state.message),
                  );
                },
              );
            }
          },
          builder: (context, state) {
            if (state is WeatherInitial) {
              return buildInput(context);
            } else if (state is WeatherLoading) {
              return buildLoading();
            } else if (state is WeatherLoaded) {
              return buildShow(context, state.weather);
            } else {
              return buildInput(context);
            }
          },
        ));
  }

  buildInput(
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: TextField(
        onSubmitted: (value) => onSubmit(context, value),
        decoration: const InputDecoration(
            suffixIcon: Icon(Icons.search),
            hintText: 'enter city name',
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.deepPurple))),
      ),
    );
  }

  onSubmit(BuildContext context, String cityName) {
    final bloc = context.read<WeatherBloc>();
    bloc.add(GetWeather(cityName));
    // final cub = context.read<WeatherCubit>();
    // cub.getWeather(cityName);
  }

  buildLoading() {
    return const Center(child: CircularProgressIndicator());
  }

  buildShow(BuildContext context, Weather weather) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(' temperture of ${weather.cityName}'),
        const SizedBox(height: 20),
        Text('${weather.temperture}',
            style: Theme.of(context).textTheme.headlineLarge),
        const SizedBox(height: 20),
        buildInput(context),
      ],
    );
  }
}
