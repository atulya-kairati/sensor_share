import 'package:flutter/material.dart';

final String kSensorSelectionPage = '/sensor_sel';
final String kServerShare = '/sensor_server';
final String kMenuPage = '/';
final String kGsmPage = '/gsm';
final String kGpsPage = '/gps';
final String kDisplayPage = '/display';
final String kHowToPage = '/about';
final String kSetting = '/setting';

final int kPort = 42069;


enum SensorName{
  TYPE_ACCELEROMETER,
  TYPE_AMBIENT_TEMPERATURE,
  TYPE_GRAVITY,
  TYPE_LIGHT,
  TYPE_LINEAR_ACCELERATION,
  TYPE_PRESSURE,
  TYPE_RELATIVE_HUMIDITY,
  TYPE_ROTATION_VECTOR,
  TYPE_PROXIMITY,
  TYPE_GYROSCOPE,
  TYPE_MAGNETIC_FIELD,
  DATE,
  TIME
}

Map<SensorName, String> sensorNameText = {
  SensorName.TYPE_ACCELEROMETER: 'accelerometer',
  SensorName.TYPE_LINEAR_ACCELERATION: 'linear_acceleration',
  SensorName.TYPE_GYROSCOPE: 'gyroscope',
  SensorName.TYPE_MAGNETIC_FIELD: 'magnetic_field',
  SensorName.TIME: 'time',
  SensorName.DATE: 'date',
  SensorName.TYPE_PROXIMITY: 'proximity',
  SensorName.TYPE_ROTATION_VECTOR: 'rotation_vector',
  SensorName.TYPE_AMBIENT_TEMPERATURE: 'temperature',
  SensorName.TYPE_GRAVITY: 'gravity',
  SensorName.TYPE_LIGHT: 'light',
  SensorName.TYPE_PRESSURE: 'pressure',
  SensorName.TYPE_RELATIVE_HUMIDITY: 'humidity',

};

int getSensorId(SensorName sensorName) {
  int id;

  // get ids here : https://developer.android.com/reference/android/hardware/Sensor#TYPE_ACCELEROMETER

  switch(sensorName){
    case SensorName.TYPE_ACCELEROMETER:
      id = 1;
      break;
    case SensorName.TYPE_LINEAR_ACCELERATION:
      id = 10;
      break;
    case SensorName.TYPE_ROTATION_VECTOR:
      id = 11;
      break;
    case SensorName.TYPE_GYROSCOPE:
      id = 4;
      break;
    case SensorName.TYPE_MAGNETIC_FIELD:
      id = 2;
      break;
    case SensorName.TYPE_AMBIENT_TEMPERATURE:
      id = 13;
      break;
    case SensorName.TYPE_GRAVITY:
      id = 9;
      break;
    case SensorName.TYPE_LIGHT:
      id = 5;
      break;
    case SensorName.TYPE_PRESSURE:
      id = 6;
      break;
    case SensorName.TYPE_RELATIVE_HUMIDITY:
      id = 12;
      break;
    case SensorName.TYPE_PROXIMITY:
      id = 8;
      break;
    case SensorName.DATE:
    // TODO: Handle this case.
      break;
    case SensorName.TIME:
    // TODO: Handle this case.
      break;
  }
  return id;
}


///---------------------------------------Widgets------------------------------///

final kButtonTextStyle = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.bold,
);