import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather_app/weather_api.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  WeatherAPI weatherAPI = WeatherAPI();
  String city = 'Hanoi';
  var _weatherData;
  var _temp;
  var _cond;
  var _condDetail;
  var _condIcon;

  void fetchWeatherData() async {
    var data = await weatherAPI.getWeather(city);
    setState(() {
      _weatherData = data;
      _temp = data['main']['temp'].toString();
      _cond = data['weather'][0]['main'].toString();
      _condDetail = data['weather'][0]['description'];
      _condIcon = data['weather'][0]['icon'];
    });
  }

  @override
  void initState() {
    super.initState();
    fetchWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _weatherData != null
          ? Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('lib/imageSource/$_cond.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Container(
                      color: Colors.black.withOpacity(0),
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TextField(
                          decoration: const InputDecoration(
                              hintText: 'Enter city name'),
                          onChanged: (value) => city = value,
                        ),
                        ElevatedButton(
                          onPressed: fetchWeatherData,
                          child: const Text('Submit'),
                        ),
                        Text(
                          'City: $city Temperature: $_temp°K Condition: $_condDetail',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
