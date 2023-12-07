// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:food_magazine/controller/cart_controller.dart';
import 'package:food_magazine/data/repository/popular_product_repo.dart';
import 'package:food_magazine/model/cart_model.dart';
import 'package:food_magazine/model/product_model.dart';
import 'package:food_magazine/utils/colors.dart';
import 'package:get/get.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;
  PopularProductController({required this.popularProductRepo});
  List<dynamic> _popularProductList = [];
  List<dynamic> get popularProductList => _popularProductList;
  late CartController _cart;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  int _quantity = 0;
  int get quantity => _quantity;
  int _inCartItems = 0;
  int get inCartItems => _inCartItems + _quantity;

  Future<void> getPopularList() async {
    Response response = await popularProductRepo.getPopularProductList();

    if (response.statusCode == 200) {
      // print("Got Product");
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      // print(_popularProductList);
      _isLoaded = true;
      update();
    } else {}
  }

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      _quantity = checkQuantity(_quantity + 1);
      // print("number of items ${_quantity}");
    } else {
      _quantity = checkQuantity(_quantity - 1);
      // print("number of items minus ${_quantity}");
    }
    update();
  }

  int checkQuantity(int quantity) {
    if ((_inCartItems + quantity) < 0) {
      Get.snackbar('Item count', "You can't reduce more!",
          backgroundColor: AppColors.mainColor, colorText: Colors.white);
      if (_inCartItems > 0) {
        _quantity = -_inCartItems;
        return _quantity;
      }
      return 0;
    } else if ((_inCartItems + quantity) > 20) {
      Get.snackbar('Item count', "You can't add more!",
          backgroundColor: AppColors.mainColor, colorText: Colors.white);
      return 20;
    } else {
      return quantity;
    }
  }

  void initProduct(ProductModel product, CartController cart) {
    _quantity = 0;
    _inCartItems = 0;
    _cart = cart;
    bool exist = false;
    exist = _cart.existInCart(product);
    // get from store _inCartItem=3
    // print('exits or not ' + exist.toString());
    if (exist) {
      _inCartItems = _cart.getQuantity(product);
    }
    // print("the quantity in the cart is " + _inCartItems.toString());
  }

  void addItem(ProductModel product) {
    _cart.addItem(product, _quantity);

    _quantity = 0;
    _inCartItems = _cart.getQuantity(product);
    _cart.items.forEach((key, value) {
      /*print("The id is " +
          value.id.toString() +
          " The quantity is " +
          value.quantity.toString());*/
    });
    update();
  }

  int get totalItems {
    return _cart.totalItems;
  }

  List<CartModel> get getItems {
    return _cart.getItems;
  }
}
