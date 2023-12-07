import 'package:flutter/material.dart';
import 'package:food_magazine/widget/small_text.dart';

class IconAndTextWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color iconColor;
  const IconAndTextWidget(
      {super.key,
      required this.icon,
      required this.text,
      required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon,color: iconColor,),
        SizedBox(width: 2,),
        SmallText(text: text,),
        SizedBox(width: 5,)
      ],
    );
  }
}
