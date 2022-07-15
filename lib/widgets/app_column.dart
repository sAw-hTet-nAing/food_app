import 'package:flutter/material.dart';
import 'package:store_app/widgets/small_text.dart';

import '../util/dimension.dart';
import 'big_text.dart';
import 'icon_and_text.dart';

class AppColumn extends StatelessWidget {
  final String text;
  AppColumn({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      BigText(
        text: text,
        size: Dimensions.font26,
      ),
      SizedBox(
        height: Dimensions.height10,
      ),
      Row(
        children: [
          Wrap(
            children: List.generate(
                5,
                (index) => Icon(
                      Icons.star,
                      color: Colors.cyanAccent,
                      size: Dimensions.font12,
                    )),
          ),
          SizedBox(
            width: Dimensions.width10,
          ),
          Smalltext(
            color: Color(0xffccc7c5),
            text: "4.5",
          ),
          SizedBox(
            width: Dimensions.height10,
          ),
          Smalltext(
            color: Color(0xffccc7c5),
            text: "1246",
          ),
          SizedBox(
            width: Dimensions.width5,
          ),
          Smalltext(
            color: Color(0xffccc7c5),
            text: "comments",
          )
        ],
      ),
      SizedBox(
        height: Dimensions.height10,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconandTextWidget(
            color: Color(0xffccc7c5),
            icon: Icons.circle_sharp,
            text: "Normal",
            iconcolor: Colors.yellow,
          ),
          SizedBox(
            width: Dimensions.width10,
          ),
          IconandTextWidget(
            color: Color(0xffccc7c5),
            icon: Icons.location_on,
            text: "1.3km",
            iconcolor: Colors.cyanAccent,
          ),
          SizedBox(
            width: Dimensions.width10,
          ),
          IconandTextWidget(
            color: Color(0xffccc7c5),
            icon: Icons.access_time,
            text: "32min",
            iconcolor: Colors.redAccent,
          )
        ],
      )
    ]);
  }
}
