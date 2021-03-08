import 'package:flutter/material.dart';
import 'package:sensor_share_final/models/constants.dart';
import 'package:sensor_share_final/models/app_state.dart';
import 'package:provider/provider.dart';



class SensorSelectionTile extends StatelessWidget {
  const SensorSelectionTile({
    Key key,
    @required this.sensorName,
  }) : super(key: key);

  final SensorName sensorName;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(sensorNameText[sensorName].replaceAll('_', ' ').toUpperCase()),
      subtitle: Provider.of<AppState>(context).sensorAvailability[sensorName]
          ? null
          : Text('Not Available'),

      onChanged: !Provider.of<AppState>(context).sensorAvailability[sensorName]
          ? null
          : (checkState) {
        Provider.of<AppState>(context, listen: false)
            .updateUseSensor(
            sensorName,
            checkState);
      },


      value: Provider.of<AppState>(context, listen: true)
          .useSensor[sensorName],
    );
  }
}