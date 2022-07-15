import 'package:flutter/material.dart';
import 'package:store_app/util/dimension.dart';
import 'package:store_app/widgets/small_text.dart';

class ExpandableText extends StatefulWidget {
  final String text;

  ExpandableText({Key? key, required this.text}) : super(key: key);

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  late String firstHalf;
  late String secHalf;

  bool hiddenText = true;

  double textHeight = Dimensions.exptextHigh;
  @override
  void initState() {
    super.initState();
    if (widget.text.length > textHeight) {
      firstHalf = widget.text.substring(0, textHeight.toInt());
      secHalf = widget.text.substring(textHeight.toInt(), widget.text.length);
    } else {
      firstHalf = widget.text;
      secHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: secHalf.isEmpty
            ? Smalltext(
                height: 1.8,
                text: firstHalf,
                size: Dimensions.font18,
              )
            : Column(
                children: [
                  Smalltext(
                      height: 1.8,
                      size: Dimensions.font18,
                      text: hiddenText
                          ? (firstHalf + "...")
                          : (firstHalf + secHalf)),
                  InkWell(
                    onTap: (() {
                      setState(() {
                        hiddenText = !hiddenText;
                      });
                    }),
                    child: Row(
                      children: [
                        Smalltext(
                          size: Dimensions.font16,
                          text: "Show more",
                          color: Colors.cyanAccent,
                        ),
                        Icon(
                          hiddenText
                              ? Icons.arrow_drop_down
                              : Icons.arrow_drop_up,
                          color: Colors.cyanAccent,
                        )
                      ],
                    ),
                  )
                ],
              ));
  }
}
