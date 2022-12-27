
import 'package:briskit/utils/color_util.dart';
import 'package:briskit/utils/text_style.dart';
import 'package:flutter/material.dart';

class LabelButton extends StatelessWidget {
  const LabelButton({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String? title;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
           
            borderRadius: BorderRadius.circular(4),
            color: kcBlack.withOpacity(0.5) ),
        child: Text(
          title!,
          style: stGrey40014.copyWith(
              color: kcWhite.withOpacity(0.8) ),
        ));
  }
}
