import 'package:flutter/material.dart';
import 'location_screen.dart';
import '../services/location.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../services/weather.dart';

class LoadingScreen extends StatefulWidget {
  final String fromPage;
  final String cityName;
  const LoadingScreen({super.key,
    required this.fromPage,
    required this.cityName,
  });

  @override
  State<StatefulWidget> createState() {
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
    var weatherData;
    if (widget.fromPage == 'location') {
      Location location = Location();
      await location.getCurrentLocation();
      weatherData = await getCityWeather(location.latitude, location.longitude);
    }
    else if (widget.fromPage == 'city'){
      weatherData = await getCityWeatherCity(widget.cityName);
    }

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
