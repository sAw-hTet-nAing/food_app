import 'package:flutter/material.dart';

class NoDataPage extends StatelessWidget {
  final String text;
  final String imgPath;
  const NoDataPage(
      {Key? key, required this.text, this.imgPath = "assets/image/empty.png"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Image.asset(
          imgPath,
          height: MediaQuery.of(context).size.height * 0.4,
          width: MediaQuery.of(context).size.width * 0.4,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.003,
        ),
        Text(
          text,
          style: TextStyle(
              fontSize: MediaQuery.of(context).size.height * 0.02,
              color: Colors.black45),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
