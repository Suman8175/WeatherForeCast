import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_forecast/Secrets.dart';
import 'package:weather_forecast/additional_info_item.dart';
import 'package:weather_forecast/hourly_forecast_items.dart';

class WeatherForecast extends StatefulWidget {
  const WeatherForecast({super.key});

  @override
  State<WeatherForecast> createState() => _WeatherForecastState();
}

class _WeatherForecastState extends State<WeatherForecast> {
  late Future<Map<String, dynamic>> currentWeather;
  Future<Map<String, dynamic>> getCurrentWeather() async {
    String cityName = 'Pokhara';
    try {
      final url = Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?q=$cityName,NP&APPID=$openWeatherApiKey&units=metric');

      var response = await http.get(url);
      final data = jsonDecode(response.body);
      if (data['cod'] != '200') {
        throw 'An unexpected error has  occurred';
      }
      return data;
      // temp = data['list'][0]['main']['temp'].toString();
    } catch (e) {
      throw (e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    currentWeather = getCurrentWeather();
  }

  @override
  Widget build(BuildContext context) {
 
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Weather ForeCasts',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        shape: const Border(),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  currentWeather = getCurrentWeather();
                });
              },
              icon: const Padding(
                padding: EdgeInsets.only(right: 12),
                child: Icon(
                  Icons.refresh_sharp,
                  size: 34,
                ),
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
            future: currentWeather,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const Center(
                      child: CircularProgressIndicator
                          .adaptive()); //.adaptive adopts loading btn acc to IOS or Android
                case ConnectionState.none:
                  return const Text('Please connect to internet');
                case ConnectionState.done:
                case ConnectionState.active:
                  final data = snapshot.data!;
                  final currentTemp =
                      data['list'][0]['main']['temp'].toString();
                  final clouds =
                      data['list'][0]['weather'][0]['main'].toString();
                  final humidity =
                      data['list'][0]['main']['humidity'].toString();
                  final pressure =
                      data['list'][0]['main']['pressure'].toString();
                  final wind = data['list'][0]['wind']['speed'].toString();
                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            shadowColor: Colors.red,
                            elevation: 10,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  Text(
                                    '$currentTemp °C',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 36),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 20, 0, 20),
                                    child: Icon(
                                      clouds == 'Rain'
                                          ? Icons.thunderstorm
                                          : clouds == 'Clear'
                                              ? Icons.sunny
                                              : Icons.cloud,
                                      size: 52,
                                    ),
                                  ),
                                  Text(
                                    clouds,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 36),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        const Text(
                          'Weather Forecast',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 19,
                              letterSpacing: 2.4),
                        ),
                        const SizedBox(height: 14),
                        SizedBox(
                          height: 150,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 5,
                              itemBuilder: (context, index) {
                                String timestamp =
                                    data['list'][index + 1]['dt'].toString();
                                DateTime dateTime =
                                    DateTime.fromMillisecondsSinceEpoch(
                                        int.parse(timestamp) * 1000);
                                int hour = dateTime.hour;
                                int minute = dateTime.minute;
                                return HourlyForecast(
                                  // time: data['list'][index + 1]['dt'].toString(),
                                  time: '$hour:$minute',
                                  temp: '23',
                                  iconChoose: data['list'][index + 1]['weather']
                                                  [0]['main']
                                              .toString() ==
                                          'Rain'
                                      ? Icons.thunderstorm
                                      : data['list'][index + 1]['weather'][0]
                                                      ['main']
                                                  .toString() ==
                                              'Clear'
                                          ? Icons.sunny
                                          : Icons.cloud,
                                );
                              }),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Additional Information',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 28,
                              letterSpacing: 2),
                        ),
                        /* Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            AdditionalInfoItem(
                              iconsfinal: Icons.water_drop,
                              humidity: 'Humidity',
                              value: humidity,
                            ),
                            AdditionalInfoItem(
                              iconsfinal: Icons.air,
                              humidity: 'Wind Speed',
                              value: wind,
                            ),
                            AdditionalInfoItem(
                              iconsfinal: Icons.compress,
                              humidity: 'Pressure',
                              value: pressure,
                            ),
                          ],
                        ), */
                        SizedBox(
                          height: 160,
                          child: ListView.builder(
                        
                            scrollDirection: Axis.horizontal,
                            itemCount: 3,
                            itemBuilder: ((context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 35),
                                child: AdditionalInfoItem(
                                  iconsfinal: index == 0
                                      ? Icons.water_drop
                                      : index == 1
                                          ? Icons.air
                                          : Icons.compress,
                                  humidity: index == 0
                                      ? 'Humidity'
                                      : index == 1
                                          ? 'Wind Speed'
                                          : 'Pressure',
                                  value: index == 0
                                      ? humidity
                                      : index == 1
                                          ? wind
                                          : pressure,
                                ),
                              );
                            }),
                          ),
                        )
                      ],
                    ),
                  );
              }
            }),
      ),
    );
  }
}
