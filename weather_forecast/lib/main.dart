import 'package:flutter/material.dart';
import 'package:weather_forecast/weather_forecast.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    print(context.runtimeType);
    return MaterialApp(
      theme:
          ThemeData(useMaterial3: true, colorScheme: const ColorScheme.dark()),
      home: const WeatherForecast(),
      debugShowCheckedModeBanner: false,
    );
  }
}
