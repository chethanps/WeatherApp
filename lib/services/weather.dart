import 'package:weatherapp/services/location.dart';
import 'package:weatherapp/services/networking.dart';

const apiKey = 'b377a7b4525277772078544b100e9373';
const openMapUrl = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  static Future getWeatherUpdate({String cityName}) async {
    NetworkHelper networkHelper;
    String requestUrl = openMapUrl;

    requestUrl += '?units=metric&&appid=$apiKey';

    if (cityName!= null && cityName.isNotEmpty) {
      requestUrl += '&&q=$cityName';
    } else {
      var location = Location();
      await location.getCurrentLocation();
      requestUrl += '&lat=${location.latitude}&lon=${location.longitude}';
    }
    print('getWeatherUpdate: Request URL ' + requestUrl);
    networkHelper = NetworkHelper(url: requestUrl);
    var decodedData = await networkHelper.getData();
    print('$decodedData');
    return decodedData;
  }

  static String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  static String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
