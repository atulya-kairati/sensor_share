import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sensor_share_final/models/constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:toast/toast.dart';
import 'package:flutter/services.dart';
import 'package:sensor_share_final/widgets/text_and_button.dart';

var geolocator = Geolocator();
var locationOptions =
    LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);

class GPSShare extends StatefulWidget {
  @override
  _GPSShareState createState() => _GPSShareState();
}

class _GPSShareState extends State<GPSShare> {
  var appState;
  final port = kPort;
  String ipAddr = '0.0.0.0';
  HttpServer server;
  int serverAccessCount = 0;
  int displayData = 0;
  Map<String, double> gpsData = {};
  List<ListTile> dataTile = [];

  @override
  void initState() {
    super.initState();
    initServer();
    printIps();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Sensor Share')),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(height: 16),
              Expanded(
                flex: 5,
                child: TextAnd2IconButton(
                  text: ' http://$ipAddr:$port',
                  icon1: Icons.content_copy,
                  function1: () {
                    Clipboard.setData(ClipboardData(
                        text: 'http://$ipAddr:$port'));
                    Toast.show("Address Copied", context,
                        duration: Toast.LENGTH_SHORT,
                        gravity: Toast.BOTTOM);
                  },
                  icon2: Icons.open_in_new,
                  function2: () {
                    print('Helo');
                    _launchURL('http://$ipAddr:$port');
                  },
                ),
              ),

//----------------------------------------------------------------------------------------
            //TODO : Reimplement This section
              Expanded(
                flex: 11,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
//                    border: Border.symmetric(
//                      horizontal: BorderSide(
//                        width: 4,
//                        color: Theme.of(context).iconTheme.color,
//                      ),
//                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [

//                      Container(
//                        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
//                        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
//                        decoration: BoxDecoration(
//                          color: Theme.of(context)
//                              .primaryColorDark
//                              .withAlpha(25),
//                          borderRadius: BorderRadius.all(Radius.circular(24)),
//                        ),
//                        child: FittedBox(
//                          child: Text('Data'),
//                        ),
//                      ),

                      Expanded(
                        child: ListView(
                          children: dataTile,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
//----------------------------------------------------------------------------------------

              Expanded(
                flex: 3,
                child: TextAndButton(
                  icon: Icons.refresh,
                  text: 'Data accessed $serverAccessCount times',
                  function: getData,
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }



  @override
  void dispose() {
    server.close();
    super.dispose();
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void initServer() async {
    server = await HttpServer.bind(
      InternetAddress.anyIPv4,
      port,
      shared: true,
    );
    print('Listening on ${server.address.address}:${server.port}');

    await for (HttpRequest request in server) {
      serverAccessCount++;
      request.response.write(jsonEncode(await getData()));
      await request.response.close();
    }
  }

  Future printIps() async {
    for (var interface in await NetworkInterface.list()) {
      if (! interface.name.trim().contains('wlan0'))
        continue; // this makes sure that wifi ip is returned
      print('== Interface: ${interface.name} ==');

      for (var addr in interface.addresses) {
        if (addr.type.name != 'IPv4') continue;
        setState(() {
          ipAddr = addr.address;
        });
        print(
            '${addr.address} ${addr.host} ${addr.isLoopback} ${addr.rawAddress} ${addr.type.name}');
      }
    }
  }

  Future<Map<String, double>> getData() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    gpsData = {
      'lat': position.latitude,
      'long': position.longitude,
      'alt': position.altitude,
    };
//    setState(() {});
    getListTiles();
    return gpsData;
  }

  void getListTiles() {
    List<ListTile> temp = [];
    gpsData.forEach((key, value) {
      temp.add(ListTile(
        title: Text(key),
        trailing: Text(value.toString()),
      ));
    });
    dataTile = temp;
    setState(() {});
  }
}


