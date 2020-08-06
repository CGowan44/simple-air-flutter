import 'package:flutter/material.dart';

class InfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green,
        title: Text(
          'Simple Air',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 42.0,
            fontFamily: 'coolvetica',
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        color: Colors.black87,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 10.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Information',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 48.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Text(
                'Simple Air is a weather/air quality monitoring application that obtains data for the current location from the IQAir AirVisual API. It uses the US-EPA scale for AQI:',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                '0 - 50 : Good',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                '51 - 100 : Moderate',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                '101 - 150 : Unhealthy for Sensitive Groups',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                '151 - 200 : Unhealthy',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                '201 - 300 : Very Unhealthy',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                '300+ : Hazardous',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                'The application accent color will change based upon the air quality. If you are having issues retrieving data, try the refresh button in the bottom right. If that fails, make sure permissions are enabled and needed services such as internet connection and location are turned on.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
