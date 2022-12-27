
import 'package:flutter/material.dart';

class BorderButton extends StatelessWidget {
  const BorderButton({Key? key, this.title, this.iconData, this.callback})
      : super(key: key);
  final String? title;
  final IconData? iconData;
  final VoidCallback? callback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: kcBlack.withOpacity(0.5)),
          ),
          child: Row(children: [
            Icon(
              iconData,
              size: 20,
              color: kcBlack.withOpacity(0.5),
            ),
            Text(
              '  $title',
              style: stGrey40014.copyWith(color: kcBlack.withOpacity(0.6)),
            )
          ])),
    );
  }
}
