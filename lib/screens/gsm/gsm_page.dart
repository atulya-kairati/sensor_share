import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sensor_share_final/models/constants.dart';
import 'package:sms_maintained/sms.dart';
import 'package:sensor_share_final/widgets/text_and_button.dart';
import 'package:flutter/services.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

//

class GSMShare extends StatefulWidget {
  @override
  _GSMShareState createState() => _GSMShareState();
}

class _GSMShareState extends State<GSMShare> {
  SmsReceiver receiver = new SmsReceiver();
  SmsSender sender = new SmsSender();
  Map<String, String> newMsg = {};
  Map<String, String> latestMsg = {};
  HttpServer server;
  int serverAccessCount = 0;
  String ipAddr = '0.0.0.0';
  int port = kPort;
  String status = '0'; // 1 if previous command was success or else 0
  List<List<String>> smsData = [];
  List<ListTile> dataTiles = [];

  void initServer() async {
    server = await HttpServer.bind(
      InternetAddress.anyIPv4,
      port,
      shared: true,
    );
    print('Listening on ${server.address.address}:${server.port}');

    await for (HttpRequest request in server) {
      serverAccessCount++;
      handleRequest(request);
    }
  }

  Future printIps() async {
    for (var interface in await NetworkInterface.list()) {
      if (! interface.name.trim().contains('wlan0'))
        continue; // this makes sure that wifi ip is returned
      print('== Interface: ${interface.name} ==');

      for (var addr in interface.addresses) {

        print(
            'helllllllo : ${addr.address} ${addr.host} ${addr.isLoopback} ${addr.rawAddress} ${addr.type.name}');

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
    // TODO: implement initState
    super.initState();
    initServer();
    printIps();
    receiveMessage();
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
                  text: ' http://$ipAddr:$port/?query=receive',
                  icon1: Icons.content_copy,
                  function1: () {
                    Clipboard.setData(ClipboardData(
                        text: 'http://$ipAddr:$port/?query=receive'));
                    Toast.show("Address Copied", context,
                        duration: Toast.LENGTH_SHORT,
                        gravity: Toast.BOTTOM);
                  },
                  icon2: Icons.open_in_new,
                  function2: () {
                    print('Helo');
                    _launchURL('http://$ipAddr:$port/?query=receive');
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
//                        width: 0,
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
                          children: dataTiles,
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
                  function: updateListTiles,
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
    final response = request.response;
    response.statusCode = HttpStatus.ok;

    if (request.uri.queryParameters['query'] == 'receive') {
      if (newMsg.isNotEmpty) {
        response.write(jsonEncode(newMsg));
        status = '1';
      } else {
        response.write('nothing new');
        status = '0';
      }
      newMsg = {};
    } else if (request.uri.queryParameters['query'] == 'send') {
      String body = request.uri.queryParameters['body'];
      String num = request.uri.queryParameters['number'];

      if (num.isNotEmpty && body.isNotEmpty) {
        SmsMessage message = SmsMessage(num, body);
        message.onStateChanged.listen((state) {
          if (state == SmsMessageState.Sent) {
            print("SMS is sent!");

            smsData.add(['SENT', num, body]); // saving it to display on list

            status = '1';
//            response.write('sent');// since this will happen in future after the server has responded it will caus eexception
          } else if (state == SmsMessageState.Fail) {
            print("SMS not sent!");
            status = '0';
//            response.write('failed');
          }
        });
        response.write('OK');
        sender.sendSms(message);
      }
    }else if(request.uri.queryParameters['query'] == 'status'){
      response.write(status);
    }else
      response.write('NO');

    response.close();
    updateListTiles();

  }

  @override
  void dispose() {
    print('Closing server....');
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

  void receiveMessage() {
    receiver.onSmsReceived.listen((SmsMessage msg) {
      print(msg.body);
      newMsg['body'] = msg.body;
      newMsg['sender'] = msg.sender;


      smsData.add(['Received', msg.sender, msg.body]); // saving it to display on list
    });
  }



  void updateListTiles() {
    print(smsData);
    List<ListTile> temp = [];

    for (var item in smsData){
      temp.add(ListTile(
//        isThreeLine: true,
        leading: Text(item[0]),
        title: Text(item[2]),
        trailing: FittedBox(child: Text(item[1])),
      ));
    }

    dataTiles = temp;
    setState(() {});
  }


}
