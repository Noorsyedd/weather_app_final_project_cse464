import '../services/network.dart';

Future<dynamic> getCityWeather(double latitude, double longitude) async {
  final String weatherUrl =
      "https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=e749ea93de0642a3344d37551b8100f3&units=metric";

  NetworkHelper networkHelper = NetworkHelper(weatherUrl);
  var weatherData = await networkHelper.getData();
  return weatherData;
}


Future<dynamic> getCityWeatherCity(String cityName) async {
  final String weatherUrl =
      "https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=5a18fc6e52dc7342ee016a20e95a106c&units=metric";

  NetworkHelper networkHelper = NetworkHelper(weatherUrl);
  var weatherData = await networkHelper.getData();
  return weatherData;
}



void fetchWeatherData(String cityName) async {
  var weatherData = await getCityWeatherCity(cityName);
}
