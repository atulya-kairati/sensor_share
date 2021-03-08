import 'package:flutter/material.dart';

class LabelIconButton extends StatelessWidget {
  LabelIconButton({
    @required this.iconData,
    @required this.textLabel,
    @required this.onPressed,
    this.iconColor,
  });

  final IconData iconData;
  final Function onPressed;
  final Color iconColor;
  final String textLabel;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onPressed,
      elevation: 8,
      highlightElevation: 4,
      animationDuration: Duration(milliseconds: 30),
      shape: RoundedRectangleBorder(
          side: BorderSide(
            color: iconColor ?? Theme.of(context).iconTheme.color,
            width: 5,
          ),
          borderRadius: BorderRadius.all(Radius.circular(8))),
      padding: EdgeInsets.fromLTRB(8,8,8,8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 7,
            child: Container(
              child: FittedBox( // scales the child according to the parent
                child: Icon(
                  iconData,
                  color: iconColor ?? Theme.of(context).iconTheme.color,
                ),
              ),
            ),
          ),
          Divider(),
          Expanded(
            flex: 3,
            child: Center(
              child: FittedBox(
//                fit: BoxFit.fill,
                child: Text(
                  textLabel,
                  style: TextStyle(
                    letterSpacing: 1,
                    fontWeight: FontWeight.w900,
                    color: Theme.of(context).textTheme.button.color,//iconColor ?? Theme.of(context).iconTheme.color,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
