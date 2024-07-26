import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey = '71ced824c06aeece5832d666f4f632a8';

  Future<Map<String, dynamic>> fetchWeather(double lat, double lon) async {
    final url =
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric';
    final response = await http.get(Uri.parse(url));
    print('WEATHER ERROR${response.body}');

    if (response.statusCode == 200) {
      print("API Response: ${response.body}");
      return json.decode(response.body);
    } else {
      print(
          "Failed to fetch weather data. Status code: ${response.statusCode}");
      print("Response: ${response.body}");
      throw Exception('Failed to load weather data');
    }
  }

  Future<Map<String, dynamic>> fetchWeatherByCity(String cityName) async {
    final url =
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
