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

  void fetchWeatherData() async {
    var data = await weatherAPI.getWeather(city);
    setState(() {
      _weatherData = data;
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
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              decoration: const InputDecoration(hintText: 'Enter city name'),
              onChanged: (value) => city = value,
            ),
            ElevatedButton(
              onPressed: fetchWeatherData,
              child: const Text('Submit'),
            ),
            _weatherData != null
                ? Expanded(
                    child: Text(
                      'City: $city Temperature: ${_weatherData['main']['temp']}°K Condition: ${_weatherData['weather'][0]['description']}',
                    ),
                  )
                : const Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }
}
