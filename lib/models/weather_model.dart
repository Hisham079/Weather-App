class Weather {
  final String cityName;
  final double temperature;
  final String description;
  final String icon;
  final double tempMax;
  final double tempMin;
  final int humidity;
  final int cloudiness;
  final double windSpeed;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.description,
    required this.icon,
    required this.tempMax,
    required this.tempMin,
    required this.humidity,
    required this.cloudiness,
    required this.windSpeed,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      temperature: json['main']['temp'],
      description: json['weather'][0]['description'],
      icon: json['weather'][0]['icon'],
      tempMax: json['main']['temp_max'],
      tempMin: json['main']['temp_min'],
      humidity: json['main']['humidity'],
      cloudiness: json['clouds']['all'],
      windSpeed: json['wind']['speed'],
    );
  }
}
