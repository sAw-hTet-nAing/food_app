import 'package:flutter/material.dart';

import '../util/dimension.dart';

class AppTextFiled extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final IconData icon;
  final bool isObsecure;

  const AppTextFiled(
      {Key? key,
      required this.textEditingController,
      required this.hintText,
      required this.icon,
      this.isObsecure = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(
            left: Dimensions.width10, right: Dimensions.width10),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  blurRadius: 3,
                  spreadRadius: 2,
                  offset: Offset(1, 1),
                  color: Colors.grey.withOpacity(0.2))
            ],
            borderRadius: BorderRadius.circular(Dimensions.radius15),
            color: Colors.white),
        child: TextField(
          obscureText: isObsecure ? true : false,
          controller: textEditingController,
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: Icon(
              icon,
              color: Colors.amber,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(Dimensions.radius15),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1.0, color: Colors.black12),
              borderRadius: BorderRadius.circular(Dimensions.radius15),
            ),
          ),
        ));
  }
}
