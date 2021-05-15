import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';

class WeatherPage extends StatefulWidget {
  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  @override
  void initState() {
    super.initState();
  }

  WeatherFactory wf = new WeatherFactory("YOUR--API--KEY");
  Weather mylocation;
  bool loading = true;

  getWeather() async {
    //1st step : request permission to access location
    await Geolocator.requestPermission();
    print('we got location !!');

    //2nd step: get latitude and logitude
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print('latitude: ${position.latitude}');
    print('longitude: ${position.longitude}');

    //3rd step: Get weather
    Weather w = await wf.currentWeatherByLocation(
        position.latitude, position.longitude);

    //4th step: assigning w to mylocation
    setState(() {
      mylocation = w;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Weather App'),
        ),
        body: loading == true
            ? Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  Container(
                      color: Colors.redAccent,
                      alignment: Alignment.center,
                      height: 250,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Currently at my location: ${mylocation.areaName}',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          Text('${mylocation.temperature.celsius}',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 50)),
                          Text('${mylocation.weatherDescription}',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20))
                        ],
                      )
                  ),

                  Expanded(
                    child: Container(
                      child: Column(
                        children: [
                          ListTile(
                            leading: Icon(Icons.thermostat_outlined),
                            title: Text('Temperature'),
                            trailing: Text('${mylocation.temperature}'),
                          ),
                          ListTile(
                            leading: Icon(Icons.cloud),
                            title: Text('Weather'),
                            trailing: Text('${mylocation.weatherDescription}'),
                          ),

                          ListTile(
                            leading: Icon(CupertinoIcons.cloud),
                            title: Text('Feels like..'),
                            trailing: Text('${mylocation.tempFeelsLike}')
                          ),

                          ListTile(
                            leading: Icon(CupertinoIcons.wind),
                            title: Text('Wind Speed'),
                            trailing: Text('${mylocation.windSpeed}'),
                          )
                        ],),
                    ))
                ],
              )
            );
  }
}
