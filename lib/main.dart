import 'package:flutter/material.dart';
import 'weatherPage.dart'

void main()
{
  runApp(myApp());
}

class myApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      title: 'Flutter Weather',
      theme: ThemeData(primaryColor: Colors.red),
      home: WeatherPage(),
    );
    
  }
}