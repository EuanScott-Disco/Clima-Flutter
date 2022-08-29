import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/weather_data.dart';

const apiKey = 'af63a195dfa436c8be1931e8743ccfaf';

class NetworkHelper {
  NetworkHelper({this.url});

  final String url;

  static Uri getLocationUri({String latitude, String longitude}) {
    Map<String, String> queryItems = {
      'lat': latitude,
      'lon': longitude,
      'appid': apiKey,
      'units': 'metric'
    };

    return _getWeatherUri(queryItems: queryItems);
  }

  static Uri getCityUri({String cityName}) {
    Map<String, String> queryItems = {
      'q': cityName,
      'appid': apiKey,
      'units': 'metric',
    };

    return _getWeatherUri(queryItems: queryItems);
  }

  static Uri _getWeatherUri({Map<String, String> queryItems}) {
    return Uri(
      scheme: 'https',
      host: 'api.openweathermap.org',
      path: '/data/2.5/weather',
      queryParameters: queryItems,
    );
  }

  static Future<WeatherData> getData({Uri url}) async {
    http.Response response = await http.get(url);

    print("Weather Data: ${response.body}");

    if (response.statusCode == 200) {
      Map<String, dynamic> temp = json.decode(response.body);

      return WeatherData.fromJson(temp);
    } else {
      print(response.statusCode);
      return Future.error(response.statusCode);
    }
  }
}
