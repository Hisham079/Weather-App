import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../services/weather_service.dart';
import '../models/weather_model.dart';

class WeatherViewModel extends ChangeNotifier {
  final WeatherService _weatherService = WeatherService();
  Weather? _weather;
  String? _errorMessage;
  bool _isLoading = false; // Add loading state

  Weather? get weather => _weather;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading; // Getter for loading state

  Future<void> fetchWeather(double lat, double lon) async {
    _setLoading(true);
    try {
      final weatherData = await _weatherService.fetchWeather(lat, lon);
      _weather = Weather.fromJson(weatherData);
      _errorMessage = null;
    } catch (e) {
      _weather = null;
      _errorMessage = e.toString();
    }
    _setLoading(false);
  }

  Future<void> fetchWeatherForCurrentLocation() async {
    _setLoading(true);
    try {
      Position position = await _determinePosition();
      await fetchWeather(position.latitude, position.longitude);
    } catch (e) {
      _weather = null;
      _errorMessage = e.toString();
      notifyListeners();
    }
    _setLoading(false);
  }

  Future<void> fetchWeatherByCity(String cityName) async {
    _setLoading(true);
    try {
      final weatherData = await _weatherService.fetchWeatherByCity(cityName);
      _weather = Weather.fromJson(weatherData);
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    }
    _setLoading(false);
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }
}
