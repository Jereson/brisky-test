import 'package:briskit/utils/color_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 90,
        width: 90,
        decoration: BoxDecoration(
            color: kc14390246, borderRadius: BorderRadius.circular(10)),
        child: const SpinKitDualRing(
          color: kcWhite,
        ),
      ),
    );
  }
}
