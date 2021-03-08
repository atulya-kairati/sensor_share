import 'package:flutter/material.dart';
import 'package:sensor_share_final/models/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AppState extends ChangeNotifier {
  Map<String, List<dynamic>> _sensorData = {};

  void updateSensorData(SensorName sensorName, List<dynamic> values) {
    //print('updateSensorData() called in sensor_selection_page');
    _sensorData[sensorNameText[sensorName]] = values;
    //notifyListeners();
  }

  void formatSensorData() {
    print('formatSensorData() called in sensor_selection_page');
    _sensorData = {};
  }

  Map<String, List<dynamic>> get sensorData => _sensorData;

  Map<SensorName, bool> _useSensor = {
    SensorName.TYPE_ACCELEROMETER: false,
    SensorName.TYPE_PROXIMITY: false,
    SensorName.DATE: false,
    SensorName.TIME: false,
    SensorName.TYPE_ROTATION_VECTOR: false,
    SensorName.TYPE_GYROSCOPE: false,
    SensorName.TYPE_LINEAR_ACCELERATION: false,
    SensorName.TYPE_MAGNETIC_FIELD: false,
    SensorName.TYPE_GRAVITY: false,
    SensorName.TYPE_RELATIVE_HUMIDITY: false,
    SensorName.TYPE_AMBIENT_TEMPERATURE: false,
    SensorName.TYPE_LIGHT: false,
    SensorName.TYPE_PRESSURE: false,
  };

  void updateUseSensor(SensorName sensorName, bool use) {
    print('updateUseSensor() called in sensor_selection_page');
    _useSensor[sensorName] = use;
    notifyListeners();
  }

  Map<SensorName, bool> get useSensor => _useSensor;


  Map<SensorName, bool> _sensorAvailability = {
    SensorName.TYPE_ACCELEROMETER: false,
    SensorName.TYPE_PROXIMITY: false,
    SensorName.TYPE_ROTATION_VECTOR: false,
    SensorName.TYPE_GYROSCOPE: false,
    SensorName.TYPE_LINEAR_ACCELERATION: false,
    SensorName.TYPE_MAGNETIC_FIELD: false,
    SensorName.TYPE_GRAVITY: false,
    SensorName.TYPE_RELATIVE_HUMIDITY: false,
    SensorName.TYPE_AMBIENT_TEMPERATURE: false,
    SensorName.TYPE_LIGHT: false,
    SensorName.TYPE_PRESSURE: false,
    SensorName.DATE: true,
    SensorName.TIME: true
  };

  void updateSensorAvailability(SensorName sensorName, bool flag){
    print('updateSensorAvailability() called in sensor_selection_page');
    _sensorAvailability[sensorName] = flag;
    notifyListeners();
  }

  Map<SensorName, bool> get sensorAvailability => _sensorAvailability;

  //---------------

  String _globalTheme = 'light';

  String get globalTheme => _globalTheme;

  void changeTheme(String name) async {
    print('changeTheme() called in app_state');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('themeName', name);
    _globalTheme = name;
    notifyListeners();
  }

}
