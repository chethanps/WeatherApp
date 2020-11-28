import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weatherapp/services/weather.dart';

import 'location_screen.dart';

class LoadingScreen extends StatefulWidget {
  final String cityName;

  LoadingScreen({this.cityName});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  void getWeatherUpdate() async {
    var weatherData = await WeatherModel.getWeatherUpdate(cityName: widget.cityName);
    print('Loading screen after getting weatherUpdate');
    print('$weatherData');
    if (weatherData != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return LocationScreen(weatherData);
        }),
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getWeatherUpdate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SpinKitDoubleBounce(
        color: Colors.white,
        size: 100.0,
      )),
    );
  }
}
