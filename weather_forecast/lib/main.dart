import 'package:flutter/material.dart';
import 'package:weather_forecast/weather_forecast.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(useMaterial3: true),
      home: const WeatherForecast(),
      debugShowCheckedModeBanner: false,
    );
  }
}
