import 'package:flutter/material.dart';


Map<String, ThemeData> themes = {
  'rose': _rose,
  'light': _light,
  'dark': _dark,
  'dark green': _darkGreen,
};

ThemeData get _rose => ThemeData(
      primaryColor: Color(0xfff50057),
      accentColor: Color(0xfff8bbd0),
      primaryColorDark: Color(0xff880e4f),
      hoverColor: Color(0xfff06292),
      brightness: Brightness.light,
      scaffoldBackgroundColor: Color(0xfffce4ec),
      cardColor: Color(0xfff8bbd0),
      toggleableActiveColor: Colors.pinkAccent,
      textTheme: TextTheme(
        headline1: TextStyle(
            fontSize: 36.0, fontWeight: FontWeight.bold, color: Colors.black54),
        headline2: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
        headline6: TextStyle(
            fontSize: 36.0,
            fontWeight: FontWeight.bold,
            color: Color(0xfffce4ec)),
        bodyText2: TextStyle(
          fontSize: 14.0,
        ),
        button: TextStyle(
          color: Color(0xfff50057),
          fontWeight: FontWeight.w600,
          letterSpacing: 2,
          textBaseline: TextBaseline.alphabetic,
        ),
        subtitle1: TextStyle(
          fontSize: 12.0,
        ),
      ),
      buttonColor: Color(0xfff8bbd0),
      iconTheme: IconThemeData(
        color: Color(0xffe91e63),
        size: 64,
      ),
    );

ThemeData get _light => ThemeData(
      primaryColor: Color(0xff0091ea),
      accentColor: Color(0xff00b0ff),
      primaryColorDark: Color(0xff272b39),
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.white,
      cardColor: Colors.black12,
      hoverColor: Colors.grey,
      toggleableActiveColor: Color(0xff00b0ff),
      textTheme: TextTheme(
        headline1: TextStyle(
          fontSize: 36.0,
          fontWeight: FontWeight.bold,
          color: Colors.black54,
        ),
        headline2: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
        headline6: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold, color: Colors.white),
        bodyText2: TextStyle(
          fontSize: 14.0,
        ),
        button: TextStyle(
          color: Colors.black54,
          fontWeight: FontWeight.w600,
          letterSpacing: 2,
          textBaseline: TextBaseline.alphabetic,
        ),
        subtitle1: TextStyle(
          fontSize: 12.0,
        ),
      ),
      buttonColor: Color(0xffffffff),
      iconTheme: IconThemeData(
        color: Colors.blue,
        size: 64,
      ),
    );

ThemeData get _dark => ThemeData(
//  cardColor: COlors.,
      primaryColor: Color(0xff0277bd),
      accentColor: Color(0xff40c4ff),
      primaryColorDark: Colors.black,
      hoverColor: Colors.black54,
      brightness: Brightness.dark,
      cardColor: Color(0xff272b39),
//  highlightColor: Colors.yellow,
      toggleableActiveColor: Color(0xff40c4ff), // color of the check box

      scaffoldBackgroundColor: Color(0xff3c3f41),
      textTheme: TextTheme(
        headline1: TextStyle(
            fontSize: 36.0, fontWeight: FontWeight.bold, color: Colors.white70),
        headline6: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold, color: Colors.white),
        headline2: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
        bodyText2: TextStyle(
          fontSize: 14.0,
        ),
        button: TextStyle(
          color: Colors.white70,
          fontWeight: FontWeight.w600,
          letterSpacing: 2,
          textBaseline: TextBaseline.alphabetic,
        ),
        subtitle1: TextStyle(
          fontSize: 12.0,
        ),
        subtitle2: TextStyle(
          fontSize: 20.0,
        ),
      ),
      buttonColor: Color(0xff272b39),
      iconTheme: IconThemeData(
        color: Colors.blue,
        size: 64,
      ),
    );

ThemeData get _darkGreen => ThemeData(
      primaryColor: Color(0xff00c853),
      accentColor: Color(0xff00e676),
      primaryColorDark: Colors.black,
      hoverColor: Colors.black54,
      brightness: Brightness.dark,
      cardColor: Color(0xff272b39),
      scaffoldBackgroundColor: Color(0xff2b2b2b),
      toggleableActiveColor: Color(0xff00e676),
      textTheme: TextTheme(
        headline1: TextStyle(
            fontSize: 36.0, fontWeight: FontWeight.bold, color: Colors.white70),
        headline2: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
        headline6: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold, color: Colors.white),
        bodyText2: TextStyle(
          fontSize: 14.0,
        ),
        button: TextStyle(
          color: Color(0xff00c853),
          fontWeight: FontWeight.w600,
          letterSpacing: 2,
          textBaseline: TextBaseline.alphabetic,
        ),
        subtitle1: TextStyle(
          fontSize: 12.0,
        ),
      ),
      buttonColor: Color(0xff272b39),
      iconTheme: IconThemeData(
        color: Color(0xff00c853),
        size: 64,
      ),
    );
