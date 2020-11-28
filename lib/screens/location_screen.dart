import 'package:flutter/material.dart';
import 'package:weatherapp/screens/city_screen.dart';
import 'package:weatherapp/services/weather.dart';
import 'package:weatherapp/utilities/constants.dart';

class LocationScreen extends StatefulWidget {
  final decodedData;

  LocationScreen(this.decodedData);

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  String cityName;
  int temperature;
  String weatherMessage;
  var weatherIcon;

  void parseWeatherData(dynamic weatherData) {
    setState(() {
      if (weatherData != null) {
        var temp = weatherData['main']['temp'];
        temperature = temp.toInt();
        cityName = weatherData['name'];
        weatherIcon = WeatherModel.getWeatherIcon(weatherData['weather'][0]['id']);
        weatherMessage = WeatherModel.getMessage(temperature);
      } else {
        temperature = 0;
        cityName = 'UnKnown';
        weatherIcon = 'Error';
        weatherMessage = 'Unable to get the location details';
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    parseWeatherData(widget.decodedData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      var weatherData = await WeatherModel.getWeatherUpdate();
                      parseWeatherData(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      var typedCityName = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return CityScreen();
                        }),
                      );
                      if(typedCityName != null){
                        var weatherData = await WeatherModel.getWeatherUpdate(cityName: typedCityName);
                        parseWeatherData(weatherData);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature c',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  weatherMessage + ' in $cityName!',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
