import 'package:flutter/material.dart';
import 'package:food_magazine/pages/home/food_page_body.dart';
import 'package:food_magazine/utils/colors.dart';
import 'package:food_magazine/utils/dimenisions.dart';
import 'package:food_magazine/widget/big_text.dart';
import 'package:food_magazine/widget/small_text.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({super.key});

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.height);
    return Scaffold(
        body: Column(children: [
      Container(
        margin: EdgeInsets.only(top: Dimenisions.height45, bottom: Dimenisions.height15),
        padding: EdgeInsets.only(left: Dimenisions.width20, right: Dimenisions.width20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                BigText(
                  text: 'Uzbekistan',
                  color: AppColors.mainColor,
                ),
                Row(
                  children: [
                    SmallText(
                      text: 'Tashkent',
                      color: Colors.black54,
                    ),
                    Icon(Icons.arrow_drop_down_rounded)
                  ],
                ),
              ],
            ),
            Center(
              child: Container(
                width: Dimenisions.height45,
                height: Dimenisions.height45,
                child: Icon(
                  Icons.search,
                  color: Colors.white,
                  size: Dimenisions.iconSize24,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimenisions.radius15),
                  color: AppColors.mainColor,
                ),
              ),
            )
          ],
        ),
      ),
      Expanded(
        child: SingleChildScrollView(
          child: FoodPageBody()
          )
      ),
    ]));
  }
}
