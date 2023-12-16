import 'package:flutter/material.dart';
import '../services/network.dart';
import 'location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() {
    return _LoadingScreenState();
  }
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  // void getLocationData() async{
  //   await Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) {
  //         return FutureBuilder(
  //           future: getCityWeather("Dhaka"),
  //           builder: (context, snapshot) {
  //             if (snapshot.connectionState == ConnectionState.waiting) {
  //               return const CircularProgressIndicator();
  //             } else if (snapshot.hasError) {
  //               return Text('Error: ${snapshot.error}');
  //             } else {
  //               return LocationScreen(
  //                 locationWeather: snapshot.data,
  //               );
  //             }
  //           },
  //         );
  //       },
  //     ),
  //   );
  // }

  void getLocationData() async {
    var weatherData = await getCityWeather("Dhaka");

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return LocationScreen(
            locationWeather: weatherData,
          );
        },
      ),
    );
  }

  Future<dynamic> getCityWeather(String cityName) async {
    const String weatherUrl =
        "https://api.openweathermap.org/data/2.5/weather?q=dhaka&appid=5a18fc6e52dc7342ee016a20e95a106c&units=metric";
    NetworkHelper networkHelper = NetworkHelper(weatherUrl);

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.09),
              BlendMode.darken,
            ),
          ),
        ),
        child: const Center(
          child: SpinKitDoubleBounce(
            color: Colors.white,
            size: 100.0,
          ),
        ),
      ),
    );
  }
}