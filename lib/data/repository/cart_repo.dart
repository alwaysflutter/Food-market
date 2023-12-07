import 'dart:convert';

import 'package:food_magazine/model/cart_model.dart';
import 'package:food_magazine/utils/app_contans.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepo {
  final SharedPreferences sharedPreferences;
  CartRepo({required this.sharedPreferences});

  List<String> cart = [];
  List<String> cartHistory = [];

  void addToCartList(List<CartModel> cartList) {
    sharedPreferences.remove(AppContans.CART_LIST);
    sharedPreferences.remove(AppContans.CART_HISTORY_LIST);

    var time = DateTime.now().toString();
    cart = [];
    /*
    convert object to substring because sharedprefense only accepts string
    */

    cartList.forEach((element) {
      element.time = time;
      return cart.add(jsonEncode(element));
    });
    // print(sharedPreferences.getStringList(AppContans.CART_LIST));
    getCartList();
  }

  List<CartModel> getCartList() {
    List<String> carts = [];
    if (sharedPreferences.containsKey(AppContans.CART_LIST)) {
      carts = sharedPreferences.getStringList(AppContans.CART_LIST)!;
      print("inside getCartList " + carts.toString());
    }
    List<CartModel> cartlist = [];

    carts.forEach(
        (element) => cartlist.add(CartModel.fromJson(jsonDecode(element))));
    return cartlist;
  }

  List<CartModel> getCartHistoryList() {
    if (sharedPreferences.containsKey(AppContans.CART_HISTORY_LIST)) {
      // cartHistory = [];
      cartHistory =
          sharedPreferences.getStringList(AppContans.CART_HISTORY_LIST)!;
    }
    List<CartModel> cartListHistory = [];
    cartHistory.forEach((element) =>
        cartListHistory.add(CartModel.fromJson(jsonDecode(element))));
    return cartListHistory;
  }

  void addToCartHistoryList() {
    if (sharedPreferences.containsKey(AppContans.CART_HISTORY_LIST)) {
      cartHistory =
          sharedPreferences.getStringList(AppContans.CART_HISTORY_LIST)!;
    }
    for (int i = 0; i < cart.length; i++) {
      cartHistory.add(cart[i]);
    }
    cartRemove();
    sharedPreferences.setStringList(AppContans.CART_HISTORY_LIST, cartHistory);
    for(int i=0;i<getCartHistoryList().length;i++){

    }
  }

  void cartRemove() {
    cart = [];
    sharedPreferences.setStringList(AppContans.CART_LIST, cart);
  }
}
