import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/const/app_const.dart';
import 'package:weatherapp/widgets/custom_search_field.dart';
import 'package:weatherapp/widgets/weather_detail_tile.dart';
import '../view_models/weather_view_model.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final weatherViewModel =
        Provider.of<WeatherViewModel>(context, listen: false);
    final TextEditingController _searchController = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      weatherViewModel.fetchWeatherForCurrentLocation();
    });

    return Scaffold(
      backgroundColor: Colors.amber.shade600,
      appBar: AppBar(
        backgroundColor: Colors.amber.shade600,
        title: Align(
          alignment: Alignment.topRight,
          child: SizedBox(
            width: MediaQuery.sizeOf(context).width / 2,
            child: CustomSearchField(
              controller: _searchController,
              onPressed: () {
                final cityName = _searchController.text;
                if (cityName.isNotEmpty) {
                  weatherViewModel.fetchWeatherByCity(cityName);
                }
              },
            ),
          ),
        ),
      ),
      body: Consumer<WeatherViewModel>(
        builder: (context, weatherViewModel, child) {
          if (weatherViewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (weatherViewModel.errorMessage != null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _showErrorDialog(context, weatherViewModel.errorMessage!);
              weatherViewModel.clearError();
            });
          }
          if (weatherViewModel.weather == null) {
            return Center(
              child: Text(
                'Unable to fetch weather data',
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else {
            final now = DateTime.now();
            final formattedDate = DateFormat('EEEE, MMM d, yyyy').format(now);
            final formattedTime = DateFormat('h:mm a').format(now);
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: MediaQuery.sizeOf(context).height * 0.3,
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          '${weatherViewModel.weather!.temperature.toStringAsFixed(0)} °C',
                          style: const TextStyle(
                              fontSize: 60,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${weatherViewModel.weather!.cityName}',
                          style: const TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          ' $formattedTime - $formattedDate',
                          style: const TextStyle(
                              fontSize: 18, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  horizontalSpace(20),
                  Container(
                    color: Colors.black12,
                    height: MediaQuery.sizeOf(context).height * 0.55,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                '${weatherViewModel.weather!.description}',
                                style: const TextStyle(
                                    fontSize: 30,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Image.network(
                              'http://openweathermap.org/img/wn/${weatherViewModel.weather!.icon}@2x.png',
                              width: 100,
                              height: 100,
                            ),
                          ],
                        ),
                        WeatherDetailtile(
                            icon: Icons.thermostat,
                            color: Colors.red.shade200,
                            label: 'Temp max',
                            value:
                                '${weatherViewModel.weather!.tempMax.toStringAsFixed(0)} °C'),
                        WeatherDetailtile(
                            icon: Icons.thermostat,
                            color: Colors.blue,
                            label: 'Temp min',
                            value:
                                '${weatherViewModel.weather!.tempMin.toStringAsFixed(0)} °C'),
                        WeatherDetailtile(
                            icon: Icons.water_drop_outlined,
                            label: 'Humidity',
                            value: '${weatherViewModel.weather!.humidity} %'),
                        WeatherDetailtile(
                            icon: Icons.cloud_outlined,
                            label: 'Cloudy',
                            value: '${weatherViewModel.weather!.cloudiness} %'),
                        WeatherDetailtile(
                            icon: Icons.air_outlined,
                            label: 'Wind Speed',
                            value: '${weatherViewModel.weather!.windSpeed} m/s')
                      ],
                    ),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }

  void _showErrorDialog(BuildContext context, String message) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    });
  }
}
