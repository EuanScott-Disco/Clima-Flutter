import '../models/weather_data.dart';
import 'location.dart';
import 'networking.dart';

class WeatherModel {
  Future<WeatherData> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    var url = NetworkHelper.getLocationUri(
      latitude: location.longitude.toStringAsFixed(7),
      longitude: location.longitude.toStringAsFixed(7),
    );

    return await NetworkHelper.getData(url: url);
  }

  Future<WeatherData> getCityWeather({String cityName}) async {
    var url = NetworkHelper.getCityUri(cityName: cityName);
    return await NetworkHelper.getData(url: url);
  }

  String getWeatherIcon(int condition) {
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

  String getMessage(int temp) {
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
