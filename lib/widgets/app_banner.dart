import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppBanner extends StatelessWidget {
  const AppBanner({
    Key key,
    @required this.width,
    this.bgColor = Colors.black,
    this.fgColor = Colors.lightBlueAccent,
    this.borderColor = Colors.blue,
  }) : super(key: key);

  final double width;
  final Color bgColor;
  final Color fgColor;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: width,
        height: width / 2.4,
        child: SvgPicture.asset(
          'images/banner.svg',
          color: fgColor,
//                      width: display_width - 64 -16,
          fit: BoxFit.fitWidth,
        ),
        decoration: BoxDecoration(
          color: bgColor,
          border: Border.all(
            color: borderColor,
            width: 4,
          ),
          borderRadius: BorderRadius.all(Radius.circular(8)),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 3),
              blurRadius: 3.0,
              spreadRadius: 3,
              color: Theme.of(context).hoverColor,
            ),
          ],
        ),
      ),
    );
  }
}
