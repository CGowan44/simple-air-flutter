import 'package:flutter_weather_icons/flutter_weather_icons.dart';
import 'package:flutter/material.dart';

String getWeatherText(var iconCode) {
  iconCode = iconCode.toString();
  if (iconCode == '01d') {
    return 'Sunny';
  } else if (iconCode == '01n') {
    return 'Fair';
  } else if (iconCode == '02d') {
    return 'Few Clouds';
  } else if (iconCode == '02n') {
    return 'Few Clouds';
  } else if (iconCode == '03d') {
    return 'Partly Cloudy';
  } else if (iconCode == '04d') {
    return 'Cloudy';
  } else if (iconCode == '09d') {
    return 'Rain Showers';
  } else if (iconCode == '10d') {
    return 'Rainy';
  } else if (iconCode == '10n') {
    return 'Rainy';
  } else if (iconCode == '50n') {
    return 'Fog';
  } else if (iconCode == '50d') {
    return 'Fog';
  } else {
    return 'Weather';
  }
}

IconData getWeatherIcon(var iconCode) {
  iconCode = iconCode.toString();
  if (iconCode == '01d') {
    return WeatherIcons.wiDaySunny;
  } else if (iconCode == '01n') {
    return WeatherIcons.wiNightClear;
  } else if (iconCode == '02d') {
    return WeatherIcons.wiDaySunnyOvercast;
  } else if (iconCode == '02n') {
    return WeatherIcons.wiNightPartlyCloudy;
  } else if (iconCode == '03d') {
    return WeatherIcons.wiDaySunnyOvercast;
  } else if (iconCode == '04d') {
    return WeatherIcons.wiDayCloudy;
  } else if (iconCode == '09d') {
    return WeatherIcons.wiDayRain;
  } else if (iconCode == '10d') {
    return WeatherIcons.wiRain;
  } else if (iconCode == '10n') {
    return WeatherIcons.wiNightRain;
  } else if (iconCode == '50n') {
    return WeatherIcons.wiNightFog;
  } else if (iconCode == '50d') {
    return WeatherIcons.wiDayFog;
  } else {
    return WeatherIcons.wiThermometer;
  }
}

MaterialColor getAccentColor(var aqi) {
  int aqiInt = int.parse(aqi);
  if (aqiInt <= 50) {
    return Colors.green;
  } else if (aqiInt <= 100) {
    return Colors.amber;
  } else if (aqiInt <= 150) {
    return Colors.orange;
  } else if (aqiInt <= 200) {
    return Colors.red;
  } else if (aqiInt <= 300) {
    return Colors.purple;
  } else if (aqiInt <= 500) {
    return Colors.brown;
  } else {
    return Colors.green;
  }
}
