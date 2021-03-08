import 'package:provider/provider.dart';
import 'package:sensor_share_final/customThemes.dart';
import 'package:sensor_share_final/models/app_state.dart';
import 'package:flutter/material.dart';

class ThemeTile extends StatelessWidget {
  const ThemeTile({
    Key key,
    @required this.themeName,
  }) : super(key: key);

  final String themeName;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if(Provider.of<AppState>(context, listen: false).globalTheme == themeName) return;
        Provider.of<AppState>(context, listen: false).changeTheme(themeName);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
            color: (Provider.of<AppState>(context).globalTheme == themeName)
                ? Theme.of(context).hoverColor.withOpacity(0.8)
                : null,
            borderRadius: BorderRadius.all(Radius.circular(16))),
        child: ListTile(
          contentPadding: EdgeInsets.all(8),
          title: Text(
            themeName.toUpperCase(),
//                    style: Theme.of(context).textTheme.subtitle2,
            style: TextStyle(
              fontSize: 16,
            ),
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
                    color: themes[themeName].primaryColor,
                  ),
                ),
                Expanded(
                  child: Container(
                    color: themes[themeName].scaffoldBackgroundColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
