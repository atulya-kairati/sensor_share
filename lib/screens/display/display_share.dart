import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:flutter/services.dart';
import 'package:sensor_share_final/models/constants.dart';
import 'package:toast/toast.dart';

HttpServer server;
String ipAddr = '0.0.0.0';
int port = kPort;
String data = 'No Data';
TextAlign textAlignment = TextAlign.justify;
IconData textAlignmentButtonIcon = Icons.format_align_left;
double dataFontSize = 32;
Color _tempMainColor;
//Color _tempShadeColor;
Color _mainColor = Colors.white;

class DisplayShare extends StatefulWidget {
  @override
  _DisplayShareState createState() => _DisplayShareState();
}

class _DisplayShareState extends State<DisplayShare> {
  void initServer() async {
    server = await HttpServer.bind(
      InternetAddress.anyIPv4,
      port,
      shared: true,
    );
    print('Listening on ${server.address.address}:${server.port}');

    await for (HttpRequest request in server) {
      handleRequest(request);
    }
  }

  Future printIps() async {
    for (var interface in await NetworkInterface.list()) {
      if (!interface.name.trim().contains('wlan0'))
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

  @override
  void initState() {
    super.initState();
    initServer();
    printIps();
  }

  @override
  void dispose() {
    server?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context)
            .primaryColorDark, //Theme.of(context).scaffoldBackgroundColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 9,
              child: Container(
                child: Text(
                  data,
                  textAlign: textAlignment,
                  style: TextStyle(
                    color: _mainColor,
                    fontSize: dataFontSize,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.info_outline),
                    onPressed: () {
                      _openDialog(
                        title: 'Address',
                        content: Text(
                          'http://$ipAddr:$port/?line1=Lorem&line2=Ipsum',
                          maxLines: 3,
                        ),
                        actionWidgetList: [
                          IconButton(
                            icon: Icon(Icons.content_copy),
                            onPressed: () {
                              Clipboard.setData(ClipboardData(
                                  text:
                                      'http://$ipAddr:$port/?line1=Lorem&line2=Ipsum'));
                              Toast.show("Address Copied", context,
                                  duration: Toast.LENGTH_SHORT,
                                  gravity: Toast.BOTTOM);
                              Navigator.pop(context);
                            },
                          )
                        ],
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.color_lens,
                      color: _mainColor,
                    ),
                    onPressed: _openMainColorPicker,
                  ),
                  IconButton(
                    icon: Icon(
                      textAlignmentButtonIcon,
                    ),
                    onPressed: () {
                      if (textAlignment == TextAlign.start) {
                        setState(() {
                          textAlignment = TextAlign.center;
                          textAlignmentButtonIcon = Icons.format_align_center;
                        });
                      } else {
                        setState(() {
                          textAlignment = TextAlign.start;
                          textAlignmentButtonIcon = Icons.format_align_left;
                        });
                      }
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.add,
                    ),
                    onPressed: () {
                      if (dataFontSize < 96)
                        setState(() {
                          dataFontSize += 2;
                        });
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.remove,
                    ),
                    onPressed: () {
                      if (dataFontSize > 8)
                        setState(() {
                          dataFontSize -= 2;
                        });
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

  void _openMainColorPicker() async {
    _openDialog(
      title: "Text Color",
      content: MaterialColorPicker(
        selectedColor: _mainColor,
        allowShades: false,
        colors: fullMaterialColors,
//        colors: [
//          Colors.red,
//          Colors.deepOrange,
//          Colors.yellow,
//          Colors.lightGreen,
//          Colors.tealAccent,
//          Colors.blue,
//          Colors.green,
//          Colors.greenAccent,
//          Colors.pink,
//          Colors.redAccent,
//          Colors.limeAccent,
//          Colors.lightBlueAccent,
//          Colors.purpleAccent,
//          Colors.cyanAccent,
//          Colors.amberAccent,
//          Colors.purple,
//          Colors.teal,
//          Colors.indigo,
//        ],
        onMainColorChange: (color) => setState(() => _tempMainColor = color),
      ),
      actionWidgetList: [
        FlatButton(
          child: Text('CANCEL'),
          onPressed: Navigator.of(context).pop,
        ),
        FlatButton(
          child: Text('SUBMIT'),
          onPressed: () {
            Navigator.of(context).pop();
            setState(() => _mainColor = _tempMainColor);
//                setState(() => _shadeColor = _tempShadeColor);
          },
        ),
      ],
    );
  }

  void _openDialog(
      {String title, Widget content, List<Widget> actionWidgetList}) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          contentPadding: const EdgeInsets.all(6.0),
          title: Text(
            title,
            style: Theme.of(context).textTheme.headline1,
          ),
          content: content,
          actions: actionWidgetList,
        );
      },
    );
  }

  void handleRequest(HttpRequest request) {
    try {
      if (request.method == 'GET') {
        handleGet(request);
      } else {
        request.response
          ..statusCode = HttpStatus.methodNotAllowed
          ..write('Unsupported request: ${request.method}.')
          ..close();
      }
    } catch (e) {
      print('Exception in handleRequest: $e');
    }
    print('Request handled.');
  }

  void handleGet(HttpRequest request) {
    String line = 'line';
    int lineNum = 1;

    print(request.uri.queryParameters);

    if (request.uri.queryParameters.isNotEmpty) {
      data = '';
      while (request.uri.queryParameters['$line$lineNum'] != null) {
        data += request.uri.queryParameters['$line$lineNum'] + '\n';
        lineNum++;
      }
      setState(() {});
    }

    final response = request.response;
    response.statusCode = HttpStatus.ok;
    response
      ..writeln("OK")
      ..close();
  }
}
