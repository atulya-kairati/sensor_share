import 'package:flutter/material.dart';

class TextAnd2IconButton extends StatelessWidget {

  final String text;
  final IconData icon1;
  final IconData icon2;
  final Function function1;
  final Function function2;

  const TextAnd2IconButton({Key key,
    @required this.text,
    @required this.icon1,
    @required this.icon2,
    @required this.function1,
    @required this.function2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
          color: Theme.of(context).buttonColor,
          border: Border.all(
            width: 4,
            color: Theme.of(context).iconTheme.color,
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 6,
            child: Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                  color: Theme.of(context)
                      .primaryColorDark
                      .withAlpha(25),
                  borderRadius:
                  BorderRadius.all(Radius.circular(24))),
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                IconButton(
                  padding: EdgeInsets.all(0),
                  icon: FittedBox(
                    fit: BoxFit.cover,
                    child: Icon(icon1),
                  ),
                  onPressed: function1,
                ),
                SizedBox(width: 16),
                IconButton(
                    padding: EdgeInsets.all(0),
                    icon: FittedBox(
                      fit: BoxFit.cover,
                      child: Icon(
                          icon2
                      ),
                    ),
                    onPressed: function2
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TextAndButton extends StatelessWidget {

  final String text;
  final IconData icon;
  final Function function;


  const TextAndButton({Key key,
    @required this.text,
    @required this.icon,
    @required this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).buttonColor,
        border: Border.all(
          width: 4,
          color: Theme.of(context).iconTheme.color,
        ),
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(32),
          bottomLeft: Radius.circular(32),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .primaryColorDark
                    .withAlpha(25),
                borderRadius: BorderRadius.all(Radius.circular(24)),
              ),
              child: FittedBox(fit: BoxFit.cover,

                child: Text(text),
              ),
            ),
          ),
          SizedBox(width: 16),
          IconButton(
            onPressed: function,
            padding: EdgeInsets.all(2),
            icon: FittedBox(child: Icon(icon)),
          ),
        ],
      ),
    );
  }
}

