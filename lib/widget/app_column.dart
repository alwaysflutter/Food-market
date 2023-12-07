import 'package:flutter/material.dart';
import 'package:food_magazine/utils/colors.dart';
import 'package:food_magazine/utils/dimenisions.dart';
import 'package:food_magazine/widget/big_text.dart';
import 'package:food_magazine/widget/icon_and_text_widget.dart';
import 'package:food_magazine/widget/small_text.dart';

class AppColumn extends StatelessWidget {
  final String text;

  const AppColumn({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(text: text,size: Dimenisions.font26,),
        SizedBox(
          height: Dimenisions.height10,
        ),
        Row(
          children: [
            Wrap(
              children: List.generate(5, (index) {
                return Icon(
                  Icons.star,
                  color: AppColors.mainColor,
                  size: 15,
                );
              }),
            ),
            SizedBox(
              width: 10,
            ),
            SmallText(
              text: '4.5',
            ),
            SizedBox(
              width: 10,
            ),
            SmallText(
              text: '1287',
            ),
            SizedBox(
              width: 10,
            ),
            SmallText(
              text: 'comments',
            ),
          ],
        ),
        SizedBox(
          height: Dimenisions.height20,
        ),
        // time and distance
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconAndTextWidget(
                icon: Icons.circle_sharp,
                text: 'Normal',
                iconColor: AppColors.iconColor1),
            IconAndTextWidget(
                icon: Icons.location_on,
                text: '1.7km',
                iconColor: AppColors.mainColor),
            IconAndTextWidget(
                icon: Icons.access_time_rounded,
                text: '32min',
                iconColor: AppColors.iconColor2)
          ],
        )
      ],
    );
  }
}
