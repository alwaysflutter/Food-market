import 'package:flutter/material.dart';

class NoDataPage extends StatelessWidget {
  final String text;
  final String imgPath;
  const NoDataPage({super.key, required this.text,this.imgPath='assets/images/cart_empty.gif'});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Image.asset(
          imgPath,
          height: MediaQuery.of(context).size.height*0.33,
          width: MediaQuery.of(context).size.width*0.33,
        ),
        SizedBox(height: MediaQuery.of(context).size.height*0.03,),
        Text(text,
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.height*0.030,
            color: Theme.of(context).disabledColor
          ),
        textAlign: TextAlign.center,
        )
      ],
    );
  }
}
