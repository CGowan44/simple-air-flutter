import 'package:flutter/material.dart';
import 'package:flutter_weather_icons/flutter_weather_icons.dart';
import 'package:geolocator/geolocator.dart';
import 'network_helper.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:android_intent/android_intent.dart';
import 'helper_functions.dart';
import 'info_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Air',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const apiKey = '616ad7b6-99a9-42c6-bc5e-2f4fa746ff40';

  Position currentPosition;
  var lat;
  var long;
  var data;
  var city;
  var aqi;
  var temp;
  var iconCode;
  String weatherText;
  IconData weatherIconData;
  MaterialColor accentColor = Colors.green;

  @override
  void initState() {
    super.initState();
    requestLocationPermission();
  }

  Future<void> requestLocationPermission() async {
    var status = await Permission.location.status;
    if (status.isDenied) {
      await Permission.location.request();
    } else {
      getCurrentPosition();
    }
  }

  void getCurrentPosition() async {
    if (await Permission.location.status.isGranted) {
      final Geolocator geolocator = Geolocator()
        ..forceAndroidLocationManager = true;
      await geolocator
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.low)
          .then((Position position) {
        currentPosition = position;
      }).catchError((e) {
        print(e);
      });
      if (currentPosition != null) {
        lat = currentPosition.latitude;
        long = currentPosition.longitude;
        NetworkHelper networkHelper = NetworkHelper(
            url:
                'http://api.airvisual.com/v2/nearest_city?lat=$lat&lon=$long&key=$apiKey');
        data = await networkHelper.getAirData();
        if (data['status'] == 'success') {
          setState(() {
            city = data['data']['city'];
            aqi = data['data']['current']['pollution']['aqius'].toString();
            temp =
                ((data['data']['current']['weather']['tp'] * (9.0 / 5.0) + 32)
                            .round())
                        .toString() +
                    '°';
            iconCode = data['data']['current']['weather']['ic'];
            weatherText = getWeatherText(iconCode);
            weatherIconData = getWeatherIcon(iconCode);
            accentColor = getAccentColor(aqi);
          });
        } else {
          return;
        }
      } else {
        lat = null;
        long = null;
        city = null;
        aqi = null;
        temp = null;
        iconCode = null;
        weatherText = null;
        weatherIconData = null;
        accentColor = Colors.green;
      }
    } else {
      if (Theme.of(context).platform == TargetPlatform.android) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Can't get current location"),
                content:
                    const Text('Please make sure you enable GPS and try again'),
                actions: <Widget>[
                  FlatButton(
                      child: Text('Ok'),
                      onPressed: () {
                        final AndroidIntent intent = AndroidIntent(
                            action:
                                'android.settings.LOCATION_SOURCE_SETTINGS');
                        intent.launch();
                        Navigator.of(context, rootNavigator: true).pop();
                      })
                ],
              );
            });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: accentColor,
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
        color: Colors.black87,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
              child: Container(
                child: Column(
                  children: [
                    Text(
                      weatherText ?? 'Waiting for Data',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 48.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                      ),
                    ),
                    Text(
                      temp ?? '??°',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 36.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      city ?? 'Waiting...',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                      ),
                    ),
                    SizedBox(
                      height: 50.0,
                    ),
                    Icon(
                      weatherIconData ?? WeatherIcons.wiDaySunny,
                      size: 100.0,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 20.0, right: 20.0, top: 40.0, bottom: 0.0),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 40.0, vertical: 0.0),
                      child: Text(
                        'AQI:',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 48.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 40.0, vertical: 0.0),
                      child: Text(
                        aqi ?? '??',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 48.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),
                  ],
                ),
                height: 80.0,
                decoration: BoxDecoration(
                  color: accentColor,
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10.0, right: 20.0, left: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.info,
                      color: Colors.white70,
                      size: 40.0,
                    ),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => InfoScreen()));
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.refresh,
                      color: Colors.white70,
                      size: 40.0,
                    ),
                    onPressed: () {
                      getCurrentPosition();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
