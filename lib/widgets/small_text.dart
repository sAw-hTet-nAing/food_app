import 'package:flutter/material.dart';
import 'package:store_app/util/dimension.dart';

class Smalltext extends StatelessWidget {
  Color? color = Color(0xffccc7c5);
  final String text;
  double size;
  double height;

  Smalltext(
      {Key? key,
      this.color = Colors.black54,
      required this.text,
      this.size = 12,
      this.height = 1.2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: color,
          fontFamily: "Roboto",
          fontSize: Dimensions.font12,
          height: height),
    );
  }
}
