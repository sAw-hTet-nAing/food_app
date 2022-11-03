import 'package:flutter/material.dart';
import 'package:store_app/util/dimension.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String buttonText;
  final bool transparent;
  final EdgeInsets? margin;
  final double? height;
  final double? width;
  final double? fontSize;
  final double? radius;
  final IconData? icon;
  CustomButton(
      {Key? key,
      this.onPressed,
      required this.buttonText,
      this.transparent = false,
      this.margin,
      this.height,
      this.width,
      this.fontSize,
      this.radius = 5,
      this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ButtonStyle _flatButton = TextButton.styleFrom(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius!)),
        maximumSize: Size(width == null ? Dimensions.screeWidth : width!,
            height != null ? height! : 50),
        backgroundColor: onPressed == null
            ? Theme.of(context).disabledColor
            : transparent
                ? Colors.transparent
                : Colors.green);

    return Center(
        child: SizedBox(
      width: width ?? Dimensions.screeWidth,
      height: height ?? 50,
      child: TextButton(
        onPressed: onPressed,
        style: _flatButton,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon != null
                ? Padding(
                    padding: EdgeInsets.only(right: Dimensions.width10),
                    child: Icon(
                      icon,
                      color: transparent
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).cardColor,
                    ),
                  )
                : SizedBox(),
            Text(buttonText,
                style: TextStyle(
                  fontSize: fontSize != null ? fontSize : Dimensions.font16,
                  color: transparent
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).cardColor,
                ))
          ],
        ),
      ),
    ));
  }
}
