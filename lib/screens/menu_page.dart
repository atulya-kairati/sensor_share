import 'package:flutter/material.dart';
import 'package:sensor_share_final/customThemes.dart';
import 'package:sensor_share_final/models/app_state.dart';
import 'package:sensor_share_final/models/constants.dart';
import 'package:sensor_share_final/widgets/app_banner.dart';
import 'package:sensor_share_final/widgets/label_icon_button.dart';

import 'package:provider/provider.dart';



class MenuPage extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    double displayWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: AppBanner(
                  width: displayWidth - 64,
                  fgColor: Theme.of(context).accentColor,
                  bgColor: Theme.of(context).primaryColorDark,
                  borderColor: Theme.of(context).accentColor,
                ),
              ),

              Divider(),

              Expanded(
                flex: 7,
                child: GridView.count(
                  primary: false,
                  padding: const EdgeInsets.all(16),
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  crossAxisCount: 3,
                  childAspectRatio: 0.8, // width : height
                  children: <Widget>[

                    LabelIconButton(
                      iconData: Icons.devices,
                      textLabel: 'Sensors',
                      onPressed: (){
                        Navigator.pushNamed(context, kSensorSelectionPage);
                      },
                    ),

                    LabelIconButton(
                      iconData: Icons.mobile_screen_share,
                      textLabel: 'Screen',
                      onPressed: (){
                        Navigator.pushNamed(context, kDisplayPage);
                      },
                    ),

                    LabelIconButton(
                      iconData: Icons.sim_card,
                      textLabel: 'GSM',
                      onPressed: (){
                        Navigator.pushNamed(context, kGsmPage);
                      },
                    ),

                    LabelIconButton(
                      iconData: Icons.location_on,
                      textLabel: 'GPS',
                      onPressed: (){
                        Navigator.pushNamed(context, kGpsPage);
                      },
                    ),

                    LabelIconButton(
                      iconData: Icons.info_outline,
                      textLabel: 'Guide',
                      onPressed: (){
                        Navigator.pushNamed(context, kHowToPage);
                      },
                    ),

                    LabelIconButton(
                      iconData: Icons.settings,
                      textLabel: 'Settings',
                      onPressed: (){
                        Navigator.pushNamed(context, kSetting);
//                      Provider.of<AppState>(context, listen: false).changeTheme(dark);
                      },
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

