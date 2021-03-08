import 'package:flutter/material.dart';
import 'package:sensor_share_final/screens/sensors/sensor_selection_page.dart';
import 'package:sensor_share_final/screens/sensors/sensor_server_share.dart';
import 'package:provider/provider.dart';
import 'package:sensor_share_final/models/app_state.dart';
import 'package:sensor_share_final/models/constants.dart';
import 'screens/menu_page.dart';
import 'screens/display/display_share.dart';
import 'screens/gps/gps_page.dart';
import 'screens/gsm/gsm_page.dart';
import 'screens/how_page.dart';
import 'customThemes.dart';
import 'screens/settings/settings_page.com.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
//      create: (BuildContext context) {},
      child: MyApp(),
      create: (_) => AppState(),
    ),
  );
}


class MyApp extends StatefulWidget {
  // This widget is the root of your application.

  @override
  _MyAppState createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    // TODO: implement initState
    getTheme(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      theme: themes[Provider.of<AppState>(context).globalTheme],
//        home: SensorSelectionPage(),
      initialRoute: kMenuPage,

      routes: {
        kMenuPage: (context) => MenuPage(),
        kSensorSelectionPage: (context) => SensorSelectionPage(),
        kServerShare: (context) => ServerShare(),
        kGpsPage: (context) => GPSShare(),
        kGsmPage: (context) => GSMShare(),
        kDisplayPage: (context) => DisplayShare(),
        kHowToPage: (context) => HowPage(),
        kSetting: (context) => SettingPage(),
      },
    );
  }

  void getTheme(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String themeName = sharedPreferences.getString('themeName') ?? 'dark';
    Provider.of<AppState>(context, listen: false).changeTheme(themeName);
  }
}
