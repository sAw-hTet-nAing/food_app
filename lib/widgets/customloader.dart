import 'package:flutter/material.dart';

import 'package:store_app/util/dimension.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: Dimensions.height20,
        width: Dimensions.height20,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.height20 / 2),
            color: Colors.white),
        alignment: Alignment.center,
        child: CircularProgressIndicator(color: Colors.green),
      ),
    );
  }
}
