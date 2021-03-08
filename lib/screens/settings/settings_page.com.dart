import 'package:flutter/material.dart';
import 'package:sensor_share_final/widgets/theme_tile.dart';

class SettingPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Container(
        margin: EdgeInsets.all(16),
        child: ListView(
          children: [
            ExpansionTile(
              childrenPadding: EdgeInsets.symmetric(horizontal: 16),
              expandedCrossAxisAlignment: CrossAxisAlignment.center,
              title: Text(
                'Themes',
                style: Theme.of(context).textTheme.headline2,
              ),
              trailing: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Colors.grey,
                    )),
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                    ),
                  ],
                ),
              ),
              children: [
                ThemeTile(themeName: 'light'),
                ThemeTile(themeName: 'dark'),
                ThemeTile(themeName: 'rose'),
                ThemeTile(themeName: 'dark green'),
              ],
            )
          ],
        ),
      ),
    );
  }
}


//void _openDialog(
//    {String title, Widget content, List<Widget> actionWidgetList}) {
//  showDialog(
//    context: context,
//    builder: (_) {
//      return AlertDialog(
//        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//        contentPadding: const EdgeInsets.all(6.0),
//        title: Text(
//          title,
//          style: Theme.of(context).textTheme.headline1,
//        ),
//        content: content,
//        actions: actionWidgetList,
//      );
//    },
//  );
//}

