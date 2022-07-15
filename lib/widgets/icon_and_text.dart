import 'package:flutter/material.dart';
import 'package:store_app/util/dimension.dart';
import 'package:store_app/widgets/small_text.dart';

class IconandTextWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;
  final Color iconcolor;
  IconandTextWidget(
      {Key? key,
      required this.icon,
      required this.text,
      required this.color,
      required this.iconcolor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: iconcolor,
        ),
        SizedBox(
          width: Dimensions.width5,
        ),
        Smalltext(
          color: color,
          text: text,
          size: Dimensions.font12,
        )
      ],
    );
  }
}
