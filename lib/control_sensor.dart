import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_sensors/flutter_sensors.dart';
import 'package:provider/provider.dart';
import 'models/app_state.dart';
import 'models/constants.dart';

class ControlSensor{

  ControlSensor(this.context, this.sensorName);

  final BuildContext context;
  final SensorName sensorName;

  StreamSubscription _streamSubscription;


  Future<void> start() async {
    print('starting $sensorName');
      final stream = await SensorManager().sensorUpdates(
        sensorId: getSensorId(sensorName),
        interval: Duration(milliseconds: 250),
//        interval: Sensors.SENSOR_DELAY_NORMAL,
      );
      _streamSubscription = stream.listen((sensorEvent) {

        List<double> cleanData = [];

        // reduces decimal points
        for(double val in sensorEvent.data){
          val = double.parse(val.toStringAsFixed(3));
          cleanData.add(val);
        }

        //proximity sensor returns a NaN at last index when activated which causes exception
        // this piece of logic takes care of that (since NaN is 0/0 its neither greater than '0' nor smaller or equal to '0'
        cleanData.removeWhere((element){
          return element.isNaN;//!(element > 0) && !(element <= 0);
        });



        Provider.of<AppState>(context, listen: false).updateSensorData(sensorName, cleanData);
      });
  }


  void stop() {
    _streamSubscription.cancel();
  }


}