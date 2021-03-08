import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sensor_share_final/models/app_state.dart';
import 'package:sensor_share_final/models/constants.dart';
import 'package:flutter_sensors/flutter_sensors.dart';
import 'package:sensor_share_final/widgets/sensor_selection_tile.dart';

class SensorSelectionPage extends StatefulWidget {
  const SensorSelectionPage({Key key, String title})
      : _title = title,
        super(key: key);

  final String _title;

  @override
  _SensorSelectionPageState createState() => _SensorSelectionPageState();
}

class _SensorSelectionPageState extends State<SensorSelectionPage> {
  bool isAccelerometerAvailable = false;
  bool isGyroscopeAvailable = false;
  bool isMagnetometerAvailable = false;
  bool isRotationAvailable = false;
  bool isLinearAccelerometerAvailable = false;
  bool isProximityAvailable = false;
  bool isLightAvailable = false;

  void checkSensorAvailability() async {
    for (SensorName sensorName in SensorName.values) {
      if (Provider.of<AppState>(context, listen: false)
          .sensorAvailability[sensorName]) continue;

      Provider.of<AppState>(context, listen: false).updateSensorAvailability(
          sensorName,
          await SensorManager().isSensorAvailable(getSensorId(sensorName)));
    }
  }

  @override
  void initState() {
    super.initState();
    checkSensorAvailability();
  }

  @override
  Widget build(BuildContext context) {
    //print(Provider.of<SensorState>(context, listen: false).sensorAvailability);
    return SafeArea(
      child: Scaffold(
//        appBar: AppBar(
//          title: Text('Sensor Share'),
//        ),
        body: Container(
          margin: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                    ),
                  ),
                  child: FittedBox(
                    child: Text(
                      'Select Sensors'.toUpperCase(),
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                flex: 16,
                child: Container(
                  color: Theme.of(context).cardColor,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        SensorSelectionTile(
                            sensorName: SensorName.TYPE_ACCELEROMETER),
                        SensorSelectionTile(
                            sensorName: SensorName.TYPE_GYROSCOPE),
                        SensorSelectionTile(sensorName: SensorName.TYPE_LIGHT),
                        SensorSelectionTile(
                            sensorName: SensorName.TYPE_GRAVITY),
                        SensorSelectionTile(
                            sensorName: SensorName.TYPE_LINEAR_ACCELERATION),
                        SensorSelectionTile(
                            sensorName: SensorName.TYPE_MAGNETIC_FIELD),
                        SensorSelectionTile(
                            sensorName: SensorName.TYPE_PROXIMITY),
                        SensorSelectionTile(
                            sensorName: SensorName.TYPE_ROTATION_VECTOR),
                        SensorSelectionTile(
                            sensorName: SensorName.TYPE_PRESSURE),
                        SensorSelectionTile(
                            sensorName: SensorName.TYPE_AMBIENT_TEMPERATURE),
                        SensorSelectionTile(
                            sensorName: SensorName.TYPE_RELATIVE_HUMIDITY),
                        SensorSelectionTile(sensorName: SensorName.TIME),
                        SensorSelectionTile(sensorName: SensorName.DATE),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                flex: 2,
                child: RaisedButton(
                  padding: EdgeInsets.all(12),
                  color: Theme.of(context).primaryColor,
                  elevation: 8,
                  highlightElevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(32),
                      bottomRight: Radius.circular(32),
                    ),
                  ),
                  child: Text(
                    'START SERVER',
                    style: TextStyle(
                      fontSize: 24,
                      letterSpacing: 3,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, kServerShare);
                  },
                ),
              ),
            ],
          ),
        ),
        // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
