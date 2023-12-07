import 'package:flutter/material.dart';
import 'package:food_magazine/utils/colors.dart';
import 'package:food_magazine/utils/dimenisions.dart';
import 'package:food_magazine/widget/small_text.dart';

class ExandableTextWidget extends StatefulWidget {
  final String text;
  const ExandableTextWidget({super.key, required this.text});

  @override
  State<ExandableTextWidget> createState() => _ExandableTextWidgetState();
}

class _ExandableTextWidgetState extends State<ExandableTextWidget> {
  late String firstHalf;
  late String secondHalf;

  bool hiddenText = true;
  double textHeight = Dimenisions.screenHeight / 5.63;

  @override
  void initState() {
    super.initState();
    if (widget.text.length > textHeight) {
      firstHalf = widget.text.substring(0, textHeight.toInt());
      secondHalf =
          widget.text.substring(textHeight.toInt() + 1, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: secondHalf.isEmpty
            ? SmallText(color: AppColors.paraColor, size: Dimenisions.font16, text: firstHalf)
            : Column(
                children: [
                  SmallText(
                    height: 1.8,
                    size: Dimenisions.font16,
                    color: AppColors.paraColor,
                      text: hiddenText
                          ? (firstHalf + '...')
                          : (firstHalf + secondHalf)),
                  InkWell(
                    onTap: () {
                      setState(() {
                        hiddenText = !hiddenText;
                      });
                    },
                    child: Row(
                      children: [
                        SmallText(
                          text: "Show more",
                          color: AppColors.mainColor,
                        ),
                        Icon(
                          hiddenText?Icons.arrow_drop_down:Icons.arrow_drop_up,
                          color: AppColors.mainColor,
                        )
                      ],
                    ),
                  )
                ],
              ));
  }
}
